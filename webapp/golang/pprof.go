package main

import (
	"net/http"
	"net/http/pprof"

	"github.com/felixge/fgprof"
	"github.com/labstack/echo/v4"
)

func AddPprofHandlers(e *echo.Echo, disabled bool) {
	if disabled {
		return
	}
	e.GET("/debug/pprof", echo.WrapHandler(http.HandlerFunc(pprof.Index)))
	e.GET("/debug/pprof/cmdline", echo.WrapHandler(http.HandlerFunc(pprof.Cmdline)))
	e.GET("/debug/pprof/profile", echo.WrapHandler(http.HandlerFunc(pprof.Profile)))
	e.GET("/debug/pprof/symbol", echo.WrapHandler(http.HandlerFunc(pprof.Symbol)))
	e.GET("/debug/pprof/trace", echo.WrapHandler(http.HandlerFunc(pprof.Trace)))

	e.GET("/debug/fgprof", echo.WrapHandler(fgprof.Handler()))
}

// go tool pprof -http="0.0.0.0:8888" http://<ip address>/debug/pprof?seconds=60
