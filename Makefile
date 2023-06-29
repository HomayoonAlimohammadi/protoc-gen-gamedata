.PHONY: gamedata generate fmt $(GAMEDATA_SRCS)

PROTOS := $(shell find ./proto -name *.proto)

GAMEDATA_SRCS := $(patsubst ./%,%,$(shell find . -path "*/autogen/*.go"))

fmt: $(GAMEDATA_SRCS)
	@echo "Formatting files..."
	@gofmt -s -w $(GAMEDATA_SRCS) && goimports -w $(GAMEDATA_SRCS) && echo "Formatted successfully!"

gamedata:
	@echo "Building protoc-gen-gamedata..."
	@go build -o $(GOPATH)/bin/protoc-gen-gamedata main.go && echo "Built successful!"

generate: gamedata
	@echo "Generating new files..."
	@protoc --go_out=. --go_opt=paths=source_relative $(PROTOS)
	@protoc --gamedata_out=. --proto_path=proto/game $(PROTOS) && echo "Generated successfully!"
	@$(MAKE) -s fmt
