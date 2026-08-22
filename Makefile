SHELL := bash

# Build rpm with code in current workdir using packit
packit: packit-mock

# Build rpm with code in current workdir using packit locally
packit-local:
	packit build locally

# Build rpm of upstream code using packit + mock
packit-mock:
	packit build in-mock --resultdir tmp
	rm *.src.rpm

# Update all spec files to latest version
update: update-golang update-golangci-lint

# Update the golang version to latest
update-golang:
	hack/update-golang.sh

# Update the golangci-lint version to latest
update-golangci-lint:
	hack/update-golangci-lint.sh

# Clean build artifacts
clean:
	hack/clean.sh

# Show this help message
help:
	@echo "Available targets:"
	@echo ""
	@awk '/^#/{c=substr($$0,3);next}c&&/^[[:alpha:]][[:alnum:]_-]+:/{print substr($$1,1,index($$1,":")),c}1{c=0}' $(MAKEFILE_LIST) | column -s: -t
	@echo ""
	@echo "Run 'make <target>' to execute a specific target."

.PHONY: \
	packit \
	packit-local \
	packit-mock \
	update \
	update-golang \
	update-golangci-lint \
	clean \
	help \
	$(NULL)
