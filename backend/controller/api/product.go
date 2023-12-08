package api

import (
	"boilerplate/models"
	"boilerplate/pkg"
	"net/http"

	"github.com/gin-gonic/gin"
)

func CreateProduct(c *gin.Context) {
	db := pkg.Database

	var input models.Product
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, models.Response{Error: err.Error()})
		return
	}

	product := models.Product{
		Name:     input.Name,
		ImageUrl: input.ImageUrl,
		Price:    input.Price,
	}
	db.Create(&product)

	c.JSON(http.StatusOK, models.Response{Data: product})
}
