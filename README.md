*This project has been created as part of the 42 curriculum by ylagzoul.*

# Inception

## Description

Inception is a system administration project focused on building a small web infrastructure with **Docker** and **Docker Compose** inside a virtual machine.

The infrastructure is made of several services, and each service runs in its own container. The Docker images are built from custom Dockerfiles using the penultimate stable version of **Debian or Alpine** as the base image.

The project does not use ready-made service images from DockerHub. Instead, each required service is built and configured manually.


### Services

| Service   | Role                                                                 |
|-----------|----------------------------------------------------------------------|
| NGINX     | Only entrypoint of the infrastructure, port 443, TLSv1.2/TLSv1.3 only |
| WordPress | WordPress + php-fpm (no NGINX inside)                                 |
| MariaDB   | Database for WordPress (no NGINX inside)                              |

## Architecture

The project is built with three separate containers:

```text
                    Browser
                       |
                    HTTPS :443
                       |
                       v
                  +---------+
                  |  NGINX  |
                  +---------+
                       |
                  FastCGI :9000
                       |
                       v
             +-------------------+
             | WordPress + PHP-FPM|
             +-------------------+
                       |
                  MariaDB :3306
                       |
                       v
                  +---------+
                  | MariaDB |
                  +---------+

          All containers use a
          dedicated Docker network
```

* A dedicated **Docker network** allows the containers to communicate with each other.
* **NGINX** is the only entry point and is accessible through port `443`.
* **WordPress + PHP-FPM** processes the PHP requests received from NGINX.
* **MariaDB** stores the WordPress database.
* Two **Docker named volumes** are used for persistent data:

  * One for the WordPress website files.
  * One for the MariaDB database.
* The volume data is stored on the host under `/home/ylagzoul/data`.
* The containers are configured to restart automatically if they crash.
* The domain `ylagzoul.42.fr` points to the local IP address of the virtual machine.

## Instructions

### Prerequisites

- A Virtual Machine (Linux)
- Docker and Docker Compose
- `make`

### Configuration

1. Add the domain to `/etc/hosts`:
   ```
   127.0.0.1   ylagzoul.42.fr
   ```
2. Create `srcs/.env` with the required variables (domain name, database name, users, etc.).

> `.env` are ignored by git. No credentials are stored in the repository.

### Build and run

```bash
make        # build the images and start the stack
make down   # stop the stack
make clean  # stop and remove containers/networks
make fclean # full cleanup, including volumes and data
make re     # rebuild everything
```

*(Adjust this list to match the targets of your Makefile.)*

### Access

- Website: `https://ylagzoul.42.fr`
- Administration panel: `https://ylagzoul.42.fr/wp-admin`

See `USER_DOC.md` and `DEV_DOC.md` for more details.

## Project description

### Use of Docker and included sources

Docker is used to isolate each service in its own container. The project sources are organized as follows:

```
.
├── Makefile
├── README.md
├── USER_DOC.md
├── DEV_DOC.md
└── srcs/
    ├── docker-compose.yml
    ├── .env
    └── requirements/
        ├── mariadb/    (Dockerfile, tools)
        ├── nginx/      (Dockerfile, conf )
        └── wordpress/  (Dockerfile, tools)
```

The Makefile calls `docker-compose.yml`, which builds each image from its own Dockerfile.

### Main design choices

- **Base image:** Debian 12 "Bookworm" (the penultimate stable release) is used for all three containers. Debian was chosen for its stability, its well-documented packages (`nginx`, `php-fpm`, `mariadb-server`), and because it keeps the three images consistent. The Dockerfiles use `FROM debian:bookworm`, not `latest`.
- **PID 1:** Each service runs in the foreground as PID 1, so Docker can send signals to it and stop it cleanly. The entrypoint scripts end with `exec`, which replaces the shell with the service. No `tail -f`, `sleep infinity` or `while true` hacks are used.
  - NGINX: `nginx -g "daemon off;"`
  - WordPress: `php-fpm8.2 -F`
  - MariaDB: `exec mariadbd --user=mysql`
- **Configuration:** Non-sensitive values (domain name, database name, database user) are stored in `srcs/.env` and passed to the containers by Docker Compose. Passwords are stored in Docker secrets and read from `/run/secrets/` at runtime by the entrypoint scripts. Nothing sensitive is written into the Dockerfiles or the images.
- **Security:**
  - NGINX is the only entrypoint, on port 443, and accepts only TLSv1.2 and TLSv1.3.
  - WordPress and MariaDB are not exposed to the host. They are reachable only through the dedicated Docker network.
  - No passwords in the Dockerfiles or in the repository (`.env` and `secrets/` are in `.gitignore`).

## Virtual Machines vs Docker

A **Virtual Machine (VM)** virtualizes the hardware of a computer. It runs a complete operating system with its own kernel.

Because it runs a full operating system, a VM usually uses more resources and takes more time to start. It also provides strong isolation between the VM and the host.

A **Docker container** does not run a complete operating system. It shares the host kernel and isolates the processes running inside the container.

Containers use fewer resources, start quickly, and are easy to move between environments. However, their isolation is weaker than a Virtual Machine.

| Virtual Machine      | Docker Container        |
| -------------------- | ----------------------- |
| Virtualizes hardware | Shares the host kernel  |
| Runs a full OS       | Runs isolated processes |
| Has its own kernel   | Uses the host kernel    |
| Uses more resources  | Uses fewer resources    |
| Slower to start      | Faster to start         |
| Strong isolation     | Lighter isolation       |


## Secrets vs Environment Variables

**Environment variables** are useful for storing normal configuration values, such as the database name or domain name. They are simple to use, but they are not the best choice for passwords because sensitive values can sometimes be exposed through commands such as `docker inspect`, logs, or process information.

**Docker secrets** are designed for sensitive information such as passwords. Docker makes the secret available inside the container as a file, usually under:

```text
/run/secrets/
```

This is safer than putting passwords directly in environment variables.

In this project:

* **Environment variables** are used for normal configuration.
* **Docker secrets** are used for passwords and other sensitive information.

For example:

```text
.env
├── DOMAIN_NAME
├── MYSQL_DATABASE
└── MYSQL_USER

secrets/
├── db_password.txt
└── db_root_password.txt
```

## Docker Network vs Host Network

A **Docker network** creates a separate network for the containers. It allows the containers to communicate with each other while keeping their network isolated from the host.

Docker also provides **internal DNS**, so containers can communicate using their service names, such as `wordpress` or `mariadb`, instead of using IP addresses.

We can also control which ports are exposed to the host. In this project, only NGINX exposes port `443`.

A **host network** removes this network isolation. The container uses the host's network stack directly.

In this project, host networking is **forbidden**. We use a dedicated Docker network to keep the containers isolated and control their communication.


## Docker Volumes vs Bind Mounts

A **Docker named volume** is managed by Docker. It allows data to be stored separately from the container, so the data can remain even if the container is removed. Named volumes are also more portable because Docker manages them.

A **bind mount** connects a specific path on the host directly to a path inside the container.

For example:

```text
Bind mount:
/home/user/data:/var/lib/mysql
```

With a bind mount, we directly choose the host directory.

In this project, **Docker named volumes are required** for the WordPress website files and the MariaDB database.

The volumes are configured so that their data is stored on the host under:

```text
/home/ylagzoul/data
```

The data remains persistent even when the containers are removed and recreated.

## Resources

### References

### Documentation

- [What is Docker?](https://www.geeksforgeeks.org/devops/introduction-to-docker/)
- [Architecture of Docker ](https://www.geeksforgeeks.org/devops/architecture-of-docker/)


### Videos

- "Docker - Containers - Images - Volumes"

  https://youtu.be/Xnu-zoqopNM?si=gSESfGMZjouN_n3d

- "What is docker"

  https://youtu.be/8Zi_8-9f7xk?si=WQaGu3mFZX2lbwtQ

- "Overlay Filesystems"

  https://www.youtube.com/watch?v=DfENwtNRlD4



### Use of AI

AI was used for the following tasks:

- **Understanding concepts:** PID 1 and signal handling in containers.
- **NGINX:** a first draft of `nginx.conf` (TLS configuration), which was then reviewed, tested and adjusted manually with a peer.

All AI-generated content was reviewed, tested and understood before being used.