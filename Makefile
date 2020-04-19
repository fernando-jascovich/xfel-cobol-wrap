# import config
conf ?= config.env
include $(conf)
export $(shell sed 's/=.*//' $(conf))

default: clean build compile run

.PHONY: build
build: ## Build the container
	docker build . -t $(IMAGE_TAG)

compile: ## Compiles cobol src
	mkdir -p build
	docker run \
		-v $(PWD):/run/cobolapp \
		$(IMAGE_TAG) \
		cobc -x -free -o build/main $(APP_ENTRYPOINT)

run: build/main ## Runs compiled source
	docker run \
       -v $(PWD):/run/cobolapp \
       $(IMAGE_TAG) \
       build/main

clean: ## Cleanup build directory
	rm -Rf build
