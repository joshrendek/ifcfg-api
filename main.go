package main

import (
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	r.LoadHTMLGlob("view/*")
	r.GET("/", func(c *gin.Context) {
		userAgent := c.Request.Header.Get("User-Agent")
		ip := c.Request.Header.Get("X-Forwarded-For")
		if strings.Contains(userAgent, "curl") {
			c.String(http.StatusOK, ip)
			return
		}

		c.HTML(http.StatusOK, "index.tmpl", gin.H{
			"ip": ip,
		})

	})
	r.Run(":5000") // listen and serve on 0.0.0.0:8080
}
