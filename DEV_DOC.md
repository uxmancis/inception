# DEVELOPER DOCUMENTATION

## ⚙️ 1. Environment Setup, Prerequisites

To run this project from scratch, the following are required:

- Linux environment (or Virtual Machine as required by the subject)
- Docker installed
- Docker Compose installed
- Make installed

## 📁 2. Project Structure
├── Makefile
├── srcs/
│ ├── docker-compose.yml
│ ├── .env
│ └── requirements/
│ ├── nginx/
│ ├── wordpress/
│ └── mariadb/

- Each service (NGINX, WordPress, MariaDB) has its own Dockerfile.
- The `docker-compose.yml` orchestrates the services.
- The `.env` file stores environment variables (credentials, domain, etc.)


## 🔐 3. Configuration & Secrets, Environment Variables
All configuration values are defined in: srcs/.env
Examples:

- Database name, user, password
- WordPress admin credentials
- Domain name

.env is not submitted to repository.

## 🚀 4. Build and Launch the Project

### Using Makefile (recommended)

1.- Build and start all services:

```bash
make
```

2.- To stop the containers:

```bash
make
```

3.- To stop the containers and delete volumes:

```bash
make clean
```

## 💾 5. Data Storage and Persistence
How to verify where are our volumes stored: 
Verification:
1) docker info | grep "Docker Root Dir"
The mountpoint will look like: /home/uxmancis/data/docker
The volume path: /home/uxmancis/data/docker/volumes/mariadb_data/_data

2) Manual verification: sudo ls /home/uxmancis/data/docker/volumes
We should see: srcs_mariadb_data   srcs_wordpress_data++