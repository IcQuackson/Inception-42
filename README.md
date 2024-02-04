<div align="center">
  <h1 style="text-align:center;">Inception-42</h1>
</div>

## Project Overview
- Welcome to Inception! This project sets up an infrastructure with various services using Docker Compose.
- Each service runs in a dedicated container, built from the stable version of Debian: bullseye-slim.
- Inception includes:
  - MariaDB.
  - WordPress with php-fpm.
  - NGINX with TLSv1.2 or TLSv1.3.
  - Volumes and persistent data for WordPress database and website files.


<p></p>
<p align="center">
  <img src="https://github.com/IcQuackson/Inception-42/assets/61185097/36c01543-3a70-4d67-bf5b-8c2d979c741b" alt="Image">
</p>

## Requirements

- Docker Compose for managing containers.
- Dockerfiles for each service, ensuring containers are built from scratch.
- Containers automatically restart in case of a crash.
- No usage of ready-made Docker images or DockerHub.
- NGINX container is the sole entry point via port 443 using TLSv1.2 or TLSv1.3.
- Prohibited usage of `network: host`, `--link`, `links:`, or infinite loops in commands or entrypoints.
- WordPress database with two users, one being the administrator, following username restrictions.
- Volumes accessible on the host machine in the `/home/login/data` folder.

## Project Structure

```plaintext
/inception
│   
│   Makefile
│
└───srcs
    |
    │   .env
    |   docker-compose.yml
    |
    │   nginx
    │       Dockerfile
    │       ...
    │
    └───wordpress
    │       Dockerfile
    │       ...
    │
    └───mariadb
            Dockerfile
            ...
```

## Usage

### Build Containers

To build the containers, use the following command:

```bash
make build
```
### Start Containers

To start the containers, run the command:

```bash
make up
```

You can check many other makefile rules in the Makefile located at the root of the project.

## Additional Notes
- NGINX is the only entry point and can be accessed via port 443.
- The domain name points to the local IP address.
- The domain name follows the pattern: login.42.fr.
- The necessary environment variables are set in the .env file at the root of the srcs directory. I included them at this git for educational reasons but never push it to a repository specially if it's public.
