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
			example.POST("/", api.CreateProduct)
		}
	}
	{
		otherGroup := apiRoute.Group("/user")
		{
			otherGroup.POST("/create", api.CreateUser)
			otherGroup.GET("/:phone", api.GetUser)
		}
	}
	{
		cart := apiRoute.Group("/cart")
		{
			cart.POST("/create", api.CreateCart)
		}
	}

	return router
}
