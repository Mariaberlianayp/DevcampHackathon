package api

import (
	"boilerplate/models"
	"boilerplate/pkg"
	"net/http"

	"github.com/gin-gonic/gin"
)

func CreateOrder(c *gin.Context) {
	db := pkg.Database

	var input models.OrderCreate
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, models.Response{Error: err.Error()})
		return
	}

	var cart models.Cart
	if result := db.Preload("CartProducts.Product").Preload("User").First(&cart, "id = ?", input.CartID); result.Error != nil {
		c.JSON(http.StatusNotFound, models.Response{Error: result.Error})
		return
	}

	var totalAmount int
	orderProducts := []models.OrderProduct{}
	for _, cartProduct := range cart.CartProducts {
		orderProduct := models.OrderProduct{
			Product:  cartProduct.Product,
			Quantity: cartProduct.Quantity,
		}
		orderProducts = append(orderProducts, orderProduct)
		totalAmount += cartProduct.Quantity * cartProduct.Product.Price
	}
	amountPerPerson := totalAmount / (len(input.InvolvedPhones) + 1)

	payments := []models.Payment{}
	for _, phone := range input.InvolvedPhones {
		var user models.User
		if result := db.First(&user, "phone = ?", phone); result.Error != nil {
			c.JSON(http.StatusNotFound, models.Response{Error: result.Error})
			return
		}

		payment := models.Payment{
			User:   user,
			Amount: amountPerPerson,
			IsPaid: false,
		}
		payments = append(payments, payment)
	}

	payments = append(payments, models.Payment{
		User:   cart.User,
		Amount: amountPerPerson,
		IsPaid: true,
	})

	order := models.Order{
		User:          cart.User,
		OrderProducts: orderProducts,
		Status:        "Menunggu Pembayaran",
		Payments:      payments,
	}

	if result := db.Create(&order); result.Error != nil {
		c.JSON(http.StatusNotFound, models.Response{Error: result.Error})
		return
	}

	c.JSON(http.StatusOK, models.Response{Data: order})
}
