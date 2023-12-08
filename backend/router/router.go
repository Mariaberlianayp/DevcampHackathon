package router

import (
	"github.com/gin-gonic/gin"

	"boilerplate/controller/api"
	"boilerplate/controller/middleware"
)

func InitializeRouter() (router *gin.Engine) {
	router = gin.Default()

	apiRoute := router.Group("/api")
	apiRoute.Use(
		middleware.CorsMiddleware,
	)
	{
		example := apiRoute.Group("/example")
		{
			example.GET("/get", api.GetAllExample)
			example.GET("/get/:id", api.GetExampleById)
			example.POST("/create", api.CreateExample)
			example.PATCH("/update/:id", api.UpdateExample)
			example.DELETE("/delete/:id", api.DeleteExample)
		}
	}

	return router
}
