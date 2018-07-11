package main

import (
	"net/http"
	"lijq-introduce/src/routers"
)

func main() {
	router:=routers.InitRouters()
	http.ListenAndServe(":8080",router)
}
