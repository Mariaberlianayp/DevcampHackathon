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
		example := apiRoute.Group("/product")
		{
			example.POST("/product", api.CreateProduct)
		}
	}

	return router
}
