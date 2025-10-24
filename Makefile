# TenstorrentCableGen Docker Compose Management

.PHONY: help build up down logs shell clean restart status

# Default target
help:
	@echo "CableGen Docker Compose Management"
	@echo ""
	@echo "Available targets:"
	@echo "  build     - Build all Docker images"
	@echo "  up        - Start all services"
	@echo "  down      - Stop all services"
	@echo "  logs      - Show logs from all services"
	@echo "  shell     - Open shell in tt-cablegen container"
	@echo "  nginx-shell - Open shell in nginx container"
	@echo "  clean     - Remove containers, networks, and volumes"
	@echo "  restart   - Restart all services"
	@echo "  status    - Show status of all services"
	@echo "  setup     - Copy env.example to .env if it doesn't exist"

# Build all images
build:
	docker-compose build

# Start all services
up:
	docker-compose up -d

# Stop all services
down:
	docker-compose down

# Show logs
logs:
	docker-compose logs -f

# Open shell in cablegen container
shell:
	docker-compose exec cablegen /bin/bash

# Open shell in nginx container
nginx-shell:
	docker-compose exec nginx /bin/bash

# Clean up everything
clean:
	docker-compose down -v --remove-orphans
	docker system prune -f

# Restart services
restart: down up

# Show service status
status:
	docker-compose ps

# Setup environment file
setup:
	@if [ ! -f .env ]; then \
		cp env.example .env; \
		echo "Created .env file from env.example"; \
		echo "Please edit .env with your configuration"; \
	else \
		echo ".env file already exists"; \
	fi