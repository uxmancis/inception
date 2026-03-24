_This project has been created as part of the 42 curriculum by uxmancis._

# inception | 42 Common Core

## Description:
🐳 Docker is a technology that enables to pack an application's code, libraries and dependencies, guaranteeing that it will run perfectly on any server in the world. It avoids "it worked on my machine" issue.

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
* [Docker in 100 Seconds](https://www.youtube.com/watch?v=Gjnup-PuquQ)

AI has been a great companion when debugging incompatibilies across services and enabling proper communication between the containers.

## Project description: 

* Virtual Machine vs Docker
* Secrets vs Environment variables
* Docker Network vs Host Network
* Docker Volumes vs Bind Mounts

Each computer has 1 Operating System
About the Operating System (OS):
* What is it? It is a software program.
What does it do? It contains the instructions that…
It offers the main user interface of the computer.
It creates the Filesystem the computer will have.
It contains the instructions that handle the hardware components of a computer.
It manages computer resources: it decides which programs use the CPU and how much memory they will use.
Where is the OS program? It is stored in Hard Drive Disk of the computer.
Examples of Operating Systems: Windows, Linux, macOS, …







Some users may need to have various Operating Systems:
Software Exclusivity and Compatibility: many applications only work on a specific system.
Developers: might be building an app for both iPhones and Androids, you need to test how it behaves on macoS and Linux/Windows environments to catch OS-specific bugs.
