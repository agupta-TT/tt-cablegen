# CableGen Docker Compose

Docker Compose setup for CableGen with Nginx reverse proxy and ACME certificate support.

## Architecture

This setup provides:
- **CableGen Flask Application**: Runs on internal port 5000
- **Nginx Reverse Proxy**: Handles SSL termination and ACME certificates on ports 80/443
- **Automatic SSL**: ACME certificate provisioning via Vault
- **Health Checks**: Service monitoring and dependency management

## Quick Start

1. **Setup environment**:
   ```bash
   make setup
   ```
   This copies `env.example` to `.env` if it doesn't exist, then edit `.env` with your values.

2. **Build and run**:
   ```bash
   make build
   make up
   ```

## Environment Variables

Required variables in `.env`:

```bash
# ACME Certificate Configuration
VAULT_ACME_DIRECTORY_URL=https://vault.yourcompany.com/v1/pki/acme/directory
VAULT_ACME_CONTACT=it@yourcompany.com

# Domain Configuration  
FQDN=cablegen.yourcompany.com
```

### Variable Descriptions

- **VAULT_ACME_DIRECTORY_URL**: Your Vault server's ACME directory endpoint for certificate provisioning
- **VAULT_ACME_CONTACT**: Email address for ACME certificate registration
- **FQDN**: Fully qualified domain name that will be used for the SSL certificate

## Local Development

For local development without ACME certificates, you can override environment variables:

### Method 1: Inline override
```bash
VAULT_ACME_DIRECTORY_URL=http://localhost:8200/v1/pki/acme/directory \
VAULT_ACME_CONTACT=dev@yourcompany.com \
FQDN=localhost \
docker-compose up
```

### Method 2: Export variables
```bash
export VAULT_ACME_DIRECTORY_URL=http://localhost:8200/v1/pki/acme/directory
export VAULT_ACME_CONTACT=dev@yourcompany.com  
export FQDN=localhost
docker-compose up
```

### Method 3: Create local .env
```bash
make setup
# Edit .env with local values
docker-compose up
```

## Management Commands

```bash
make setup     # Copy env.example to .env (if .env doesn't exist)
make build     # Build all Docker images
make up        # Start all services
make down      # Stop all services
make logs      # View logs from all services
make status    # Check status of all services
make restart   # Restart all services
make clean     # Remove containers, networks, and volumes
make shell     # Open shell in cablegen container
make nginx-shell # Open shell in nginx container
```

## Troubleshooting

- **Certificate issues**: Check that your FQDN resolves to the server and Vault ACME is accessible
- **Service won't start**: Run `make logs` to see error messages
- **Port conflicts**: Ensure ports 80 and 443 are available on the host
- **Build failures**: Check that all required files are present in the nginx/ directory