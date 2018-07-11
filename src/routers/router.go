package routers

import (
	"github.com/gin-gonic/gin"
	"lijq-introduce/src/handle"
)

//初始化路由
func InitRouters() *gin.Engine {
	r:=gin.Default()

	r.LoadHTMLGlob("templates/*")
	r.Static("/assets/","./statics/assets/")
	r.Static("/images/","./statics/images/")

	r.GET("/",handle.Index)
	return r
}
