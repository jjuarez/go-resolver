ifeq ($(GOBIN),)
GOBIN := $(GOPATH)/bin
endif

BIN := $(GOBIN)/resolver

all: clean build

clean:
	@rm $(BIN) 2>/dev/null || true

build: *.go
	@go build -o $(BIN) $^

.PHONY: build
.SILENT: clean
