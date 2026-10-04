# Developer Documentation

## Introduction

This document explains how to set up, build, run, and manage the Inception project.

The project uses Docker and Docker Compose to create a small web infrastructure with three services:

* NGINX
* WordPress + PHP-FPM
* MariaDB

Each service runs in its own Docker container.

---

# Project Structure

The main project structure is:

```text
.
├── Makefile
├── README.md
├── USER_DOC.md
├── DEV_DOC.md
├── secrets/
│   ├── db_password.txt
│   └── db_root_password.txt
│
└── srcs/
    ├── .env
    ├── docker-compose.yml
    │
    └── requirements/
        ├── nginx/
        │   ├── Dockerfile
        │   ├── conf/
        │   └── tools/
        │
        ├── wordpress/
        │   ├── Dockerfile
        │   ├── conf/
        │   └── tools/
        │
        └── mariadb/
            ├── Dockerfile
            ├── conf/
            └── tools/
```

---

# Prerequisites

Before building the project, make sure the following are installed and working:

* A Virtual Machine
* Docker
* Docker Compose
* Make
* Git
* A working network connection

The project must be run inside a Virtual Machine.

Check Docker:

```bash
docker --version
```

Check Docker Compose:

```bash
docker compose version
```

Check Make:

```bash
make --version
```

---

# Configuration

The main Docker Compose configuration is:

```text
srcs/docker-compose.yml
```

Normal environment variables are stored in:

```text
srcs/.env
```

The `.env` file contains non-sensitive configuration.

For example:

```text
DOMAIN_NAME=ylagzoul.42.fr
MYSQL_DATABASE=wordpress
MYSQL_USER=...
```

Do not put passwords directly in the Dockerfile.

---

# Secrets

Sensitive information is stored in the `secrets` directory.

Example:

```text
secrets/
├── db_password.txt
└── db_root_password.txt
```

These files contain passwords used by MariaDB and WordPress.

Secret files must not be committed to a public Git repository.

The project uses Docker secrets to make sensitive values available to the containers.

Inside the container, a secret can be available under:

```text
/run/secrets/
```

---

# Domain Configuration

The project uses:

```text
ylagzoul.42.fr
```

The domain must point to the local IP address of the Virtual Machine.

For local testing, add the domain to `/etc/hosts` if necessary.

Example:

```text
127.0.0.1    ylagzoul.42.fr
```

The IP address depends on the VM network configuration.

---

# Dockerfiles

Each service has its own Dockerfile.

```text
srcs/requirements/nginx/Dockerfile
srcs/requirements/wordpress/Dockerfile
srcs/requirements/mariadb/Dockerfile
```

The Dockerfiles build the images used by the project.

The project uses Debian as the base distribution.

The services are built separately:

```text
NGINX
  |
  +-- NGINX image

WordPress
  |
  +-- WordPress + PHP-FPM image

MariaDB
  |
  +-- MariaDB image
```

---

# Build the Project

From the project root:

```bash
make
```

The Makefile is responsible for building the Docker images and starting the project.

You can also build the images directly with Docker Compose:

```bash
cd srcs
docker compose build
```

To build only one service:

```bash
docker compose build nginx
```

```bash
docker compose build wordpress
```

```bash
docker compose build mariadb
```

---

# Start the Project

Start the containers in detached mode:

```bash
cd srcs
docker compose up -d
```

The `-d` option runs the containers in the background.

Check the containers:

```bash
docker compose ps
```

The expected services are:

```text
nginx
wordpress
mariadb
```

---

# Stop the Project

To stop and remove the containers:

```bash
docker compose down
```

This removes the containers but keeps the named volumes unless they are explicitly removed.

---

# Rebuild the Project

If a Dockerfile or configuration has changed, rebuild the required image.

For example:

```bash
docker compose build wordpress
```

Then restart the service:

```bash
docker compose up -d
```

To rebuild everything:

```bash
docker compose build
docker compose up -d
```

---

# Managing Containers

List running containers:

```bash
docker ps
```

List all containers:

```bash
docker ps -a
```

Check the Compose services:

```bash
docker compose ps
```

Open a shell inside a container:

```bash
docker exec -it nginx bash
```

For WordPress:

```bash
docker exec -it wordpress bash
```

For MariaDB:

```bash
docker exec -it mariadb bash
```

The exact shell available depends on the base image and installed packages.

---

# Logs

View all service logs:

```bash
docker compose logs
```

Follow the logs:

```bash
docker compose logs -f
```

View one service:

```bash
docker compose logs nginx
```

```bash
docker compose logs wordpress
```

```bash
docker compose logs mariadb
```

Logs are useful when debugging startup, network, PHP-FPM, NGINX, or database problems.

---

# Managing Images

List Docker images:

```bash
docker images
```

The project builds its own images for the required services.

Remove an unused image:

```bash
docker rmi <image>
```

Before removing an image, make sure that it is not needed by a running container.

---

# Managing the Docker Network

The project uses a dedicated Docker network.

List networks:

```bash
docker network ls
```

Inspect the project network:

```bash
docker network inspect inception
```

The containers use service names to communicate.

For example:

```text
wordpress -> mariadb
```

WordPress connects to MariaDB using the service name:

```text
mariadb
```

This works because Docker provides internal DNS for the Docker network.

---

# Managing Volumes

The project uses two named volumes:

```text
WordPress volume
MariaDB volume
```

List volumes:

```bash
docker volume ls
```

Inspect a volume:

```bash
docker volume inspect <volume_name>
```

The persistent data is configured to end up under:

```text
/home/ylagzoul/data/
```

The main data directories are:

```text
/home/ylagzoul/data/wordpress
/home/ylagzoul/data/mariadb
```

These are Docker named volumes configured with the local volume driver.

---

# Data Persistence

The WordPress website files are stored in the WordPress named volume.

Inside the WordPress container, the files are available at:

```text
/var/www/html
```

MariaDB stores its database files in:

```text
/var/lib/mysql
```

The data is kept in the MariaDB named volume.

Because the data is stored in volumes, recreating a container does not normally remove the data.

For example:

```text
Remove container
       |
       v
Volume remains
       |
       v
Create new container
       |
       v
Same data is available
```

---

# NGINX Configuration

NGINX is the only public entry point.

It listens on:

```text
443
```

and uses HTTPS.

The NGINX configuration forwards PHP requests to:

```text
wordpress:9000
```

The communication uses FastCGI.

The flow is:

```text
Browser
   |
   | HTTPS :443
   v
NGINX
   |
   | FastCGI :9000
   v
WordPress + PHP-FPM
```

NGINX does not communicate directly with MariaDB.

---

# WordPress and PHP-FPM

WordPress runs inside its own container.

PHP-FPM processes PHP requests received from NGINX.

The basic request flow is:

```text
Browser
   |
   v
NGINX
   |
   v
PHP-FPM
   |
   v
WordPress
   |
   v
MariaDB
```

WordPress uses MariaDB to store website data.

---

# MariaDB

MariaDB runs in its own container.

It stores the WordPress database.

The database service is available to the other containers through the Docker network.

The database is not exposed directly to the host.

The normal communication is:

```text
WordPress
    |
    | MariaDB :3306
    v
MariaDB
```

---

# Useful Development Commands

### Build everything

```bash
docker compose build
```

### Start everything

```bash
docker compose up -d
```

### Stop everything

```bash
docker compose down
```

### Rebuild one service

```bash
docker compose build wordpress
```

### Restart one service

```bash
docker compose restart wordpress
```

### View service status

```bash
docker compose ps
```

### View logs

```bash
docker compose logs -f
```

### List containers

```bash
docker ps -a
```

### List images

```bash
docker images
```

### List volumes

```bash
docker volume ls
```

### List networks

```bash
docker network ls
```

---

# Debugging

When a service does not work, check the problem step by step.

## 1. Check the containers

```bash
docker compose ps
```

Make sure all required services are running.

## 2. Check the logs

```bash
docker compose logs nginx
docker compose logs wordpress
docker compose logs mariadb
```

## 3. Check the network

```bash
docker network inspect inception
```

Make sure the containers are connected to the same network.

## 4. Check the volumes

```bash
docker volume ls
```

Make sure the required volumes exist.

## 5. Check the configuration

Review:

```text
srcs/.env
srcs/docker-compose.yml
```

and the configuration files inside:

```text
srcs/requirements/
```

---

# Clean Rebuild

If the project needs to be rebuilt from the images, use:

```bash
docker compose down
docker compose build
docker compose up -d
```

Be careful when removing volumes.

Do not use:

```bash
docker compose down -v
```

unless you intentionally want to remove the Docker volumes and their persistent data.

---

# Makefile

The Makefile is located at the root of the project and wraps Docker Compose.

| Target | Action |
|--------|--------|
| `make` | Create the data directories, build the images and start the stack |
| `make down` | Stop the containers |
| `make clean` | Stop and remove containers and networks |
| `make fclean` | Full cleanup, including volumes and the data under `/home/ylagzoul/data` |
| `make re` | Rebuild everything from scratch |

---

# Development Workflow

A normal development workflow is:

```text
1. Modify the configuration or Dockerfile
              |
              v
2. Build the changed service
              |
              v
3. Start/recreate the service
              |
              v
4. Check the logs
              |
              v
5. Test the website
```

For example, after changing the WordPress Dockerfile:

```bash
docker compose build wordpress
docker compose up -d
docker compose logs -f wordpress
```

---

# Important Rules

When modifying the project, keep the following rules:

* Do not use `network: host`.
* Do not use Docker `links`.
* Do not use `--link`.
* Do not use infinite loops to keep containers alive.
* Do not use `tail -f` as a container process.
* Do not use `sleep infinity`.
* Do not put passwords inside Dockerfiles.
* Do not use the `latest` tag.
* Keep the required services in separate containers.
* Keep NGINX as the only public entry point.
* Keep persistent data in Docker named volumes.
* Do not remove volumes unless the stored data is no longer needed.

---

# Data Location

The project uses Docker named volumes for persistent storage.

The data is configured to be stored under:

```text
/home/ylagzoul/data/
```

The main directories are:

```text
/home/ylagzoul/data/wordpress
/home/ylagzoul/data/mariadb
```

The WordPress volume contains the website files.

The MariaDB volume contains the database files.

This allows the data to remain available when containers are recreated.

---

# Summary

The main development commands are:

```bash
# Build and start
make

# Check services
docker compose -f srcs/docker-compose.yml ps

# View logs
docker compose -f srcs/docker-compose.yml logs -f

# Stop containers
docker compose -f srcs/docker-compose.yml down

# Rebuild
docker compose -f srcs/docker-compose.yml build

# Start again
docker compose -f srcs/docker-compose.yml up -d

# Check volumes
docker volume ls

# Check network
docker network ls
```

The project is managed using **Docker Compose**, while persistent data is stored in **Docker named volumes** and sensitive information is handled using **Docker secrets**.
