package main

import (
	"github.com/HomayoonAlimohammadi/protoc-gen-gamedata/gamedata"
	"google.golang.org/protobuf/compiler/protogen"
)

func main() {
	protogen.Options{}.Run(func(p *protogen.Plugin) error {
		return gamedata.Generate(p)
	})
}
