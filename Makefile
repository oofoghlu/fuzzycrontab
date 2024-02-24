##@ Build Dependencies

## Location to install dependencies to
LOCALBIN ?= $(shell pwd)/bin
$(LOCALBIN):
	mkdir -p $(LOCALBIN)

## Tool Binaries
GOJUNIT ?= $(LOCALBIN)/go-junit-report

.PHONY: all
all: build test

.PHONY: fmt
fmt:
	go fmt ./...

.PHONY: vet
vet:
	go vet ./...

.PHONY: install-test-deps
install-test-deps:
	GOBIN=$(LOCALBIN) go install github.com/jstemmer/go-junit-report/v2@latest

.PHONY: build
build: fmt vet
	go build -o bin/fuzzycrontab ./pkg/fuzzycrontab/fuzzycrontab.go

.PHONY: test
test: fmt vet install-test-deps
	go test ./... -coverprofile cover.out | $(GOJUNIT) -iocopy -set-exit-code -out report.xml
