# Frappe 15 and ERPNext 15 setup in docker

These instruction will create container which is needed to run Frappe framework and ERPNext version 15 up and running  in your local machine. This version uses ubuntu image 22.04

## Prerequisites

[Docker](https://www.docker.com/)

[Docker Compose](https://docs.docker.com/compose/overview/)

### Build the container and install bench

* Clone the repo with\

        git clone <-URL of the repo->\

        cd frappe-docker-setup

* Build the frappe container with\

        docker build -t frappe:1.0 .

* For next step if you are using windows be sure to use git bash terminal because the commands are bash commands specifically made for linux based system and git bash already provide this interface\

    Enter the folder location if your not in the frappe-docker-setup folder the following command will create all the required containers.

        .\dbench setup docker

* For next step use following command. These step is only required for first time setup:
    if you want to change site name you can find it in

        conf\frappe\environment.env

    you can change it here

    Run these command to setup frappe and erpnext

        .\dbench init-frappe
        .\dbench init-erpnext  (for installing erp next)

#### Frappe and erpnext installation is done for step you need to use it every time you start your container

        ./dbench setup hosts

#### You can run all the bench command from git bash using

        ./dbench <comands>  (Don't use bench in command eg: ./dbench start without bench)

#### Site will be running in 127.0.0.1:80

        docker ps or docker ps -a

#### Your ubuntu interactive interface can be accessed using

        ./dbench

#### All the port mapping are

    ports:
      - "3306:3306"     mariadb-port
      - "80:8000"       webserver-port
      - "11000:11000"   redis-cache
      - "12000:12000"   redis-queue
      - "13000:13000"   redis-socketio
      - "9000:9000"     socketio-port
      - "6787:6787"     file-watcher-port
