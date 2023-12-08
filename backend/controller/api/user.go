package api

import (
	"boilerplate/models"
	"boilerplate/pkg"
	"net/http"

	"github.com/gin-gonic/gin"
)

const userNotFoundMessage = "user not found"
const phoneNumberNotEmptyMessasge = "phone number cannot empty"

func CreateUser(c *gin.Context) {
	db := pkg.Database

	var input models.User
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, models.Response{Error: err.Error()})
		return
	}

	user := models.User{
		Name:  input.Name,
		Phone: input.Phone,
		Pin:   input.Pin,
	}
	db.Create(&user)

	c.JSON(http.StatusOK, models.Response{Data: user})
}

func GetUser(c *gin.Context) {
	db := pkg.Database

	phone := c.Query("phone")
	if phone == "" {
		c.JSON(http.StatusBadRequest, models.Response{Error: phoneNumberNotEmptyMessasge})
		return
	}

	var user models.User
	if result := db.First(&user, " = ?", phone); result.Error != nil {
		c.JSON(http.StatusNotFound, models.Response{Error: userNotFoundMessage})
		return
	}

	c.JSON(http.StatusOK, models.Response{Data: user})
}
