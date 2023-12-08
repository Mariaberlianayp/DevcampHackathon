package main

import (
	"fmt"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"

	"boilerplate/config"
	"boilerplate/pkg"
	"boilerplate/router"
)

func main() {
	c, err := config.InitializeConfig()
	if err != nil {
		panic(err)
	}

	if c.Server.Debug {
		gin.SetMode(gin.DebugMode)
	} else {
		gin.SetMode(gin.ReleaseMode)
	}

	err = pkg.InitializeSqlite(c.Database)
	if err != nil {
		panic(err)
	}

	s := &http.Server{
		Addr:           fmt.Sprintf(":%d", c.Server.Port),
		Handler:        router.InitializeRouter(),
		ReadTimeout:    10 * time.Second,
		WriteTimeout:   10 * time.Second,
		MaxHeaderBytes: 1 << 20,
	}
	if err := s.ListenAndServe(); err != nil {
		panic("[ERROR] Failed to listen and serve")
	}
}
