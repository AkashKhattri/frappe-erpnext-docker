# Frappe 15 and ERPNext 15 setup in docker

These instruction will create container which is needed to run Frappe framework and ERPNext version 15 up and running  in your local machine. This version uses ubuntu image 22.04

## Prerequisites

[Docker](https://www.docker.com/)

[Docker Compose](https://docs.docker.com/compose/overview/)

### Build the container and install bench

* Clone the repo with

        git clone <-URL of the repo->\

        cd frappe-docker-setup

* Bind mounts

    When you use a bind mount, a file or directory on the host machine is mounted into a container. The file or directory is referenced by its absolute path on the host machine. By contrast, when you use a volume, a new directory is created within Docker's storage directory on the host machine, and Docker manages that directory's contents.

    If you want to use bind mounts replace this line in docker-compose.yml file inside frappe-docker-setup

            - frappe-bench-volume:/home/frappe/frappe-bench:rw
    with

            - ./frappe-bench:/home/frappe/frappe-bench:rw


* Build the frappe container with

        docker build -t frappe:15.0 .

* For next step if you are using windows be sure to use git bash terminal because the commands are bash commands specifically made for linux based system and git bash already provide this interface

    Enter the folder location if your not in the frappe-docker-setup folder the following command will create all the required containers.

        .\dbench setup docker

* For next step use following command. These step is only required for first time setup:
    if you want to change site name you can find it in

        conf\frappe\environment.env

    you can change it here

    Run these command to setup frappe and erpnext

        .\dbench init-frappe

        .\dbench init-erpnext  (for installing erp next)

    If you get mysql/mariadb access denied error then please run the following command

        docker exec -it mariadb bash

        root@f206bfa4df54:/# mariadb -uroot -p<your-database-password> (default password is frappe)

        MariaDB [(none)]> GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '<your-database-password>' WITH GRANT OPTION;

        MariaDB [(none)]> FLUSH PRIVILEGES;


#### Frappe and erpnext installation is done for step you need to use it every time you start your container

        ./dbench setup hosts

#### Then run following command

        ./dbench use <your-site-name> (default: erpdev.com)

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
