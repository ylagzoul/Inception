# User Documentation

## Introduction

This document explains how to use and manage the Inception infrastructure.

Inception is a small web infrastructure that runs a WordPress website. It is made of three services, each running in its own Docker container:

* **NGINX**: the web server. It receives all visitors' requests over HTTPS and is the only part of the infrastructure reachable from outside.
* **WordPress + PHP-FPM**: the website itself. WordPress is the content management system, and PHP-FPM is the process manager that executes its PHP code.
* **MariaDB**: the database server. It stores the website's content, settings and user accounts.

---

# Services

## NGINX

NGINX is a web server used here as the single entry point of the infrastructure.

Its role is to:

* accept HTTPS connections on port `443` only, using TLSv1.2 or TLSv1.3;
* encrypt the traffic with the TLS certificate;
* serve static files (images, CSS, JavaScript);
* forward PHP requests to the WordPress container, which processes them.

NGINX does not run PHP itself. It only passes the work to PHP-FPM.

## WordPress + PHP-FPM

WordPress is the content management system that powers the website: pages, posts, themes, plugins and the administration panel.

PHP-FPM (FastCGI Process Manager) is the service that runs the PHP code of WordPress. It waits for requests from NGINX, executes the PHP code, queries the database when needed, and sends the result back to NGINX.

This container contains only WordPress and PHP-FPM, without NGINX.

## MariaDB

MariaDB is the database server (a MySQL-compatible relational database). It stores everything WordPress needs to work: posts, pages, comments, settings and user accounts (the administrator and the regular user).

It is only reachable from the Docker network. It is not exposed to the host or to the internet.

---

# Starting and Stopping the Project

Go to the root directory of the repository:

```bash
cd <repository_root>
```

| Action | Command |
| ------ | ------- |
| Start the project (build images and start containers) | `make` |
| Stop the project (containers are removed, data is kept) | `make down` |
| Stop and remove containers and networks | `make clean` |
| Full cleanup, **including all data** | `make fclean` |
| Rebuild everything from scratch | `make re` |

> **Warning:** `make fclean` deletes the Docker volumes and the data stored under `/home/ylagzoul/data/`. The website content and the database will be lost.

Before the first start, make sure the domain is declared in `/etc/hosts`:

```text
127.0.0.1   ylagzoul.42.fr
```

(Use the IP address of the virtual machine if you access the site from another machine.)

---

# Accessing the Website

Open a browser and go to:

```text
https://ylagzoul.42.fr
```

The website uses HTTPS only. The project uses a self-signed certificate (not issued by a trusted authority), so the browser may show a security warning. This is expected in this local environment, and you can accept the warning to continue.

Plain HTTP (port `80`) is not available.

---

# WordPress Administration Panel

The administration panel is the back office of WordPress, where the administrator manages pages, posts, users, themes and settings.

It is available at:

```text
https://ylagzoul.42.fr/wp-admin
```

Log in with the WordPress administrator username and password configured for the project (see the Credentials section below).

---

# Credentials

Credentials are the usernames and passwords the services need to work. Sensitive ones are stored separately from the normal project configuration.

## Where they are located

| Type | Location | Content |
| ---- | -------- | ------- |
| Environment variables | `srcs/.env` | Non-sensitive values: domain name, database name, usernames ,Passwords|

Example of the `.env` file content:

```text
DB_NAME=wordpress
DB_USER=ylagzoul
DB_PASSWORD=xxxxxx
ROOT_PASSWORD=xxxxx
DB_HOST=mariadb
```


## WordPress accounts

The WordPress administrator and the regular user are created automatically at the first start. Their usernames and passwords are defined in `srcs/.env`. The administrator username does not contain the word "admin", as required by the project rules.

## Changing a password

1. Edit the corresponding file the value in `srcs/.env`.
2. Run `make fclean`, then `make`, to recreate the stack.

> **Warning:** `make fclean` deletes the existing website and database data. The database keeps its old password until it is recreated, so a simple restart is not enough.

## Keeping credentials safe

* Never share or publish the `.env` file.
* Both are ignored by Git and must stay out of the repository.

---

# Checking that the Services Are Running

## Containers

```bash
docker compose -f srcs/docker-compose.yml ps
```

or:

```bash
docker ps
```

You should see the three services running:

```text
nginx
wordpress
mariadb
```

## Quick functional checks

* Open `https://ylagzoul.42.fr`: the WordPress website should load.
* Log in at `https://ylagzoul.42.fr/wp-admin` with the administrator account.
* Check that `http://ylagzoul.42.fr` (port `80`) does not work.

## Logs

Logs are the messages written by each service while it runs. They are the first place to look when something does not work.

```bash
docker compose -f srcs/docker-compose.yml logs          # all services
docker compose -f srcs/docker-compose.yml logs -f       # follow live
docker compose -f srcs/docker-compose.yml logs nginx
docker compose -f srcs/docker-compose.yml logs wordpress
docker compose -f srcs/docker-compose.yml logs mariadb
```

---

# Data Storage and Persistence

A Docker named volume is a storage area managed by Docker that keeps data outside the container, so the data survives when the container is stopped, removed or recreated.

The project uses two named volumes:

* **WordPress volume**: the website files (themes, plugins, uploads, configuration).
* **MariaDB volume**: the database files.

On the host machine, the data is stored under:

```text
/home/ylagzoul/data/wordpress
/home/ylagzoul/data/mariadb
```

List the volumes with:

```bash
docker volume ls
```

The data is kept when you run `make down`. It is only deleted by `make fclean`.

---

# Docker Network

A Docker network is a private virtual network that connects the containers together and isolates them from the rest of the host. Inside it, each container can reach the others by its service name (for example, WordPress reaches the database with the name `mariadb`), so no fixed IP address is needed.

List the networks to find the exact name of the project network:

```bash
docker network ls
```

---

# Basic Troubleshooting

## The website does not open

1. Check the containers: `docker compose -f srcs/docker-compose.yml ps`
2. Check the NGINX logs: `docker compose -f srcs/docker-compose.yml logs nginx`
3. Check that `ylagzoul.42.fr` is declared in `/etc/hosts` and points to the VM IP address.

## WordPress returns an error

```bash
docker compose -f srcs/docker-compose.yml logs wordpress
```

Make sure PHP-FPM is running correctly.

## Database connection problem

```bash
docker compose -f srcs/docker-compose.yml logs mariadb
docker compose -f srcs/docker-compose.yml logs wordpress
```

Make sure MariaDB is running and that WordPress uses the correct database name, user and password.

---

# Quick Commands

| Action | Command |
| ------ | ------- |
| Start project | `make` |
| Stop project | `make down` |
| Full cleanup (deletes data) | `make fclean` |
| Rebuild everything | `make re` |
| Check containers | `docker compose -f srcs/docker-compose.yml ps` |
| Show logs | `docker compose -f srcs/docker-compose.yml logs` |
| Follow logs | `docker compose -f srcs/docker-compose.yml logs -f` |
| Restart containers | `docker compose -f srcs/docker-compose.yml restart` |
| List volumes | `docker volume ls` |
| List networks | `docker network ls` |

---

# Important Notes

* Do not delete the Docker volumes unless you intentionally want to delete the persistent data.
* Do not publish passwords or secret files.
* NGINX is the only public entry point, through HTTPS on port `443`.
* MariaDB is not directly exposed to the host.
* WordPress and MariaDB communicate through the Docker network.