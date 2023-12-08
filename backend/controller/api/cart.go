package api

import (
	"boilerplate/models"
	"boilerplate/pkg"
	"net/http"

	"github.com/gin-gonic/gin"
)

func CreateCart(c *gin.Context) {
	db := pkg.Database

	var input models.CartCreate
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, models.Response{Error: err.Error()})
		return
	}

	var user models.User
	if result := db.First(&user, "phone = ?", input.Phone); result.Error != nil {
		c.JSON(http.StatusNotFound, models.Response{Error: result.Error})
		return
	}

	cartProducts := []models.CartProduct{}
	for _, cartCreateProduct := range input.CartCreateProducts {
		var product models.Product
		if result := db.First(&product, "id = ?", cartCreateProduct.ProductID); result.Error != nil {
			c.JSON(http.StatusNotFound, models.Response{Error: result.Error})
			return
		}
		cartProduct := models.CartProduct{
			Product:  product,
			Quantity: cartCreateProduct.Quantity,
		}
		cartProducts = append(cartProducts, cartProduct)
	}

	cart := models.Cart{
		User:         user,
		CartProducts: cartProducts,
	}

	if result := db.Create(&cart); result.Error != nil {
		c.JSON(http.StatusNotFound, models.Response{Error: result.Error})
		return
	}

	c.JSON(http.StatusOK, models.Response{Data: cart})
}

func GetCart(c *gin.Context) {
	db := pkg.Database

	var user models.User
	if result := db.First(&user, "phone = ?", c.Param("phone")); result.Error != nil {
		c.JSON(http.StatusNotFound, models.Response{Error: result.Error})
		return
	}

	var cart models.Cart
	if result := db.Preload("User").Preload("CartProducts.Product").First(&cart, "user_id = ?", user.ID); result.Error != nil {
		c.JSON(http.StatusNotFound, models.Response{Error: result.Error})
		return
	}

	totalAmount := 0
	for _, cartProducts := range cart.CartProducts {
		totalAmount += cartProducts.Product.Price * cartProducts.Quantity
	}
	cart.TotalAmount = totalAmount

	c.JSON(http.StatusOK, models.Response{Data: cart})
}
