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
	for _, product := range input.CartCreateProducts {
		cartProduct := models.CartProduct{
			ProductID: product.ProductID,
			Quantity:  product.Quantity,
		}
		cartProducts = append(cartProducts, cartProduct)
	}

	cart := models.Cart{
		UserID:       user.ID,
		CartProducts: cartProducts,
	}

	db.Create(&cart)

	c.JSON(http.StatusOK, models.Response{Data: cart})
}
