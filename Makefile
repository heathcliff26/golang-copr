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

# Update the golang version to latest
update:
	hack/update.sh

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
	clean \
	help \
	$(NULL)
