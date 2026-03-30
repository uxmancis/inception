_This project has been created as part of the 42 curriculum by uxmancis._

# inception | 42 Common Core

## Description:
🐳 Docker is a technology that enables to pack 📦 an application's code, libraries and dependencies, guaranteeing that it will run perfectly on any server in the world. It avoids "it worked on my machine" issue.

This is a System Administration exercise that allowed me to get into containerization, as I've had to build my own containers.

The setup includes: NGINX, WordPress and MariaDB, each service runs in its own container and communicates with the others, forming a functional web architecture.


## Instructions: 
1. Clone the respository
```bash 
git clone https://github.com/uxmancis/inception.git inception_uxu
```

2. Build containers
```bash 
make
```

3. Search in browser:
```bash
https://uxmancis.42.fr
```

4. Clean up containers
```bash
make clean 
```

## Resources:
Here you have a few resources I'd like to share:
* [How to Install Ubuntu Linux VM on a Mac (M1 / M2 / M3 / M4 / M5) with UTM!](https://www.youtube.com/watch?v=1PL-0-5BNXs)
* [Docker in 100 Seconds](https://www.youtube.com/watch?v=Gjnup-PuquQ)
* [The Only Docker Tutorial You Need To Get Started](https://www.youtube.com/watch?v=DQdB7wFEygo)
* [Virtualization Explained](https://www.youtube.com/watch?v=FZR0rG3HKIk)
* [Containerization Explained](https://www.youtube.com/watch?v=0qotVMX-J5s)
* [Virtual Machines vs Containers](https://www.youtube.com/shorts/bKtnt1yagEE)

AI has been a great companion when debugging incompatibilies across services and enabling proper communication between the containers.


## Project description: 
This project is built using [Docker](https://www.docker.com/), a containerization platform that allows applications to run in isolated environments called containers. Each service (e.g., web server, database) runs independently but communicates through a shared network.

The project includes:
- Dockerfiles → define how each service is built
- docker-compose.yml → orchestrates all services together
- Volumes → persist data (e.g., database storage)
- Networks → enable communication between containers

🔧 Main design choices
- Microservice architecture: each component runs in its own container
- Isolation: services are decoupled (e.g., web server ≠ database)
- Reproducibility: same environment across all machines
- Portability: can run anywhere Docker is installed


* Virtual Machine vs Docker: both are virtualization techniques.
Docker enables lightweidht, portable, and reproducible environments.

| Virtual Machines (VMs)   | Docker (Containers)       |
| ------------------------ | ------------------------- |
| Run full OS per instance | Share host OS kernel      |
| Heavy (GBs)              | Lightweight (MBs)         |
| Slow startup             | Fast startup              |
| Strong isolation         | Process-level isolation   |
| Managed via hypervisor   | Managed via Docker engine |


* Secrets vs Environment variables
Environment Variables are designed to be used for configuration (ports, modes, etc.). On the other hand, Secrets are designed to store sensitive data.

| Secrets                                           | Environment Variables             |
| ------------------------------------------------- | --------------------------------- |
| Designed for sensitive data (passwords, API keys) | General configuration             |
| Stored securely (encrypted / restricted access)   | Plain text (less secure)          |
| Not easily exposed                                | Can be visible in logs/processes  |
| Managed by Docker or orchestration tools          | Defined in `.env` or compose file |

I've chosen to use environment variables combines with .gitignore, as subject requires any credentials, API keys or passwords not to be in our git repository. Secrets are not mandatory to be used in the project.


* Docker Network vs Host Network


* Docker Volumes vs Bind Mounts
A Docker Volume is a storage managed by Docker itself. Docker decides where: /var/lib/docker/volumes/volume_name/_data. We do NOT control de path. Docker manages lifecycle, permissions, etc. It's more portable and safe.

A bind mound is when WE choose the exact folder on our machine. We tell Docker to use a specific folder on our computer. We do have full control. It's less portable, as it's not managed by Docker.

That's why Docker Volumes are used for persistency and production-safe data. On the other hand, bind mounts are used for development and live file editing.

The key difference is that volumes, docker owns the data. On bind mounts, we do own the data.

We've configured daemon.json so that data is stored in home. It's not been managed in docker-compose.yml, but in daemon.json, the brain of Docker.