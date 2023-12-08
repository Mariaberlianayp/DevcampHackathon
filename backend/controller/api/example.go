package api

import (
	"net/http"

	"github.com/gin-gonic/gin"

	"boilerplate/models"
	"boilerplate/pkg"
)

func GetAllExample(c *gin.Context) {
	db := pkg.Database

	var examples []models.Example
	if result := db.Find(&examples); result.Error != nil {
		c.JSON(http.StatusNotFound, models.Response{Error: result.Error})
		return
	}

	c.JSON(http.StatusOK, models.Response{Data: examples})
}

func GetExampleById(c *gin.Context) {
	db := pkg.Database

	var example models.Example
	if result := db.First(&example, c.Param("id")); result.Error != nil {
		c.JSON(http.StatusNotFound, models.Response{Error: result.Error})
		return
	}

	c.JSON(http.StatusOK, models.Response{Data: example})
}

func CreateExample(c *gin.Context) {
	db := pkg.Database

	var input models.ExampleCreate
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, models.Response{Error: err.Error()})
		return
	}

	example := models.Example{
		Name: input.Name,
		Desc: input.Desc,
	}
	db.Create(&example)

	c.JSON(http.StatusOK, models.Response{Data: example})
}

func UpdateExample(c *gin.Context) {
	db := pkg.Database

	var input models.ExampleUpdate
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, models.Response{Error: err.Error()})
		return
	}

	var example models.Example
	if result := db.First(&example, c.Param("id")); result.Error != nil {
		c.JSON(http.StatusNotFound, models.Response{Error: result.Error})
		return
	}

	if result := db.Model(&example).Updates(models.Example{
		Name: input.Name,
		Desc: input.Desc,
	}); result.Error != nil {
		c.JSON(http.StatusBadRequest, models.Response{Error: result.Error})
		return
	}

	c.JSON(http.StatusOK, models.Response{Data: example})
}

func DeleteExample(c *gin.Context) {
	db := pkg.Database

	if result := db.Delete(&models.Example{}, "id = ?", c.Param("id")); result.Error != nil {
		c.JSON(http.StatusNotFound, models.Response{Error: result.Error})
		return
	}

	c.JSON(http.StatusOK, models.Response{Data: "Example deleted"})
}
