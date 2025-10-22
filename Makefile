# Prevent commands with secrets from being saved in history
export HISTCONTROL=ignorespace

.PHONY: build run run-debug

# Build the visualizer container using pre-built base from GHCR
build:
	cd $(shell git rev-parse --show-toplevel) && docker build --platform linux/amd64 -f Dockerfile -t tt-cablegen .

run: build
	docker run --platform linux/amd64 -p 5000:5000 -e LOG_LEVEL=$${LOG_LEVEL:-INFO} tt-cablegen

run-debug: build
	docker run --platform linux/amd64 -p 5000:5000 -e LOG_LEVEL=DEBUG -d -it tt-cablegen

