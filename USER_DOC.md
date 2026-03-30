# USER DOCUMENTATION

## Overview of the Services

This project provides a web infrastructure composed of three main services:

- **NGINX** → Acts as the entry point (HTTPS, port 443)
- **WordPress (php-fpm)** → Handles the website logic
- **MariaDB** → Stores the website database

The services are connected through a Docker network and run in separate containers.

---

## Run the Project

1. To build and start all services:

```bash
make

```

2. Search in browser:
```bash
https://uxmancis.42.fr

```
3. Access the Administration Panel, log in putting user and password:
```bash
https://uxmancis.42.fr/wp-admin

```
You must log in using the administrator credentials defined in the `.env` file.

Example:

- Username: defined by WP_ADMIN_USER
- Password: defined by WP_ADMIN_PASSWORD


4. To stop the project: services:

```bash
make clean
```