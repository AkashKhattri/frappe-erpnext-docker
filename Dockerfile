FROM ubuntu:22.04
LABEL MAINTAINER frappe

USER root

ENV LANG C.UTF-8

RUN apt-get update

RUN apt install software-properties-common -y

RUN apt update

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt update

# export timezone - for python3.9-dev install
ENV TZ=Asia

# place timezone data /etc/timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt install python3.11-full -y
RUN apt-get install git -y
RUN apt-get install python3-dev -y
RUN apt-get install python3-setuptools python3-pip -y
RUN apt install python3.11-venv -y

RUN apt-get update \
	&& apt-get install -y redis-tools redis-server libffi-dev  \
	libssl-dev libmysqlclient-dev \
	curl git sudo software-properties-common nano nginx cron wkhtmltopdf \
	xvfb libfontconfig mariadb-client mariadb-common \
	&&curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash - \
	&& apt-get install -y nodejs \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*


RUN pip3 install --upgrade setuptools pip && rm -rf ~/.cache/pip

RUN useradd -ms /bin/bash -G sudo frappe && printf '# User rules for frappe\nfrappe ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/frappe

USER frappe

WORKDIR /home/frappe

COPY --chown=frappe:frappe ./conf/frappe/ /home/frappe/frappe-bench-settings/

USER root

RUN npm install -g yarn

RUN pip3 install frappe-bench \
	&& rm -rf ~/.cache/pip \
	&& chown -R frappe:frappe /home/frappe/*

USER frappe

RUN mkdir -p /home/frappe/frappe-bench
WORKDIR /home/frappe/frappe-bench









# ENV MONGO_DB_USERNAME=admin \
#     MONGO_DB_PWD=password

# RUN mkdir -p /home/app

# COPY ./app /home/app

# # set default dir so that next commands executes in /home/app dir
# WORKDIR /home/app

# # will execute npm install in /home/app because of WORKDIR
# RUN npm install

# # no need for /home/app/server.js because of WORKDIR
# CMD ["node", "server.js"]

