package main

import "github.com/gin-gonic/gin"

func main() {
	r := gin.Default()
	r.GET("/", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
			"headers": c.Request.Header,
		})
	})
	r.Run(":5000") // listen and serve on 0.0.0.0:8080
}
