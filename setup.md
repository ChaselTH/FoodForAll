# Setup Guide

## Environment configuration

### Clone the project code from GitLab to local at the command line
```
git clone https://git.shefcompsci.org.uk/com6103-2021-22/team08/project.git
```

### Download and install node.js
You can follow the officiak

### Download and install Anaconda

### Configure DJango environment and dependencies

Go to the server-app by `cd ./server-app`.

Execute the command:
```
conda env create -f environment_{systemtype}.yml
```
{systemtype} is replaced with the current operating system name, e.g. `windows`, `mac`

### Install and setup MySQL

### Add database for the project in MySQL

Login Mysql as administrator and execute the following commands in order:
```mysql
CREATE DATABASE foodforall;
create user 'apex'@'%' identified by 'apex08';
grant all privileges on *.* to 'apex'@'%';
flush privileges;
```

### Init table of project database using DJango

Go to the server-app by `cd ./server-app`.

execute the following commands in sequence:

```shell
conda activate tsp
python manage.py makemigrations
python manage.py migrate
```

**Note: The back-end services must be configured on the same machine as the front-end services.**

### Set up front end dependencies 

Go to the web-app by `cd ./web-app`.

Then run: 

```shell
npm install
```

## Starting the services

### Start back-end service 

**(the service will be slow to start for the first time)**

Go to the server-app by `cd ./server-app`.

Execute the command as follow:

```shell
conda activate tsp
python manage.py runserver --noreload 0.0.0.0:8000
```

### Start front-end service

Go to the web-app by `cd ./web-app`.

Then run

```shell
npm start
```

**At this point, the server is successfully started and the main project page can be accessed by opening http://localhost:3000/**

## Docker 快速启动（推荐用于服务器部署）

### 需要的软件

- Docker
- Docker Compose (v2)

### 启动步骤

在项目根目录执行：

```shell
docker compose up --build
```

服务启动完成后：

- 前端：http://localhost:3000
- 后端：http://localhost:8000

### 关闭服务

```shell
docker compose down
```

## Linux 服务器部署 Docker

以下以 Ubuntu 为例：

1. 安装 Docker 与 Compose：

```shell
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

2. 启动 Docker 并设置开机自启：

```shell
sudo systemctl enable --now docker
```

3. 将当前用户加入 docker 组（避免每次使用 sudo）：

```shell
sudo usermod -aG docker $USER
newgrp docker
```

4. 在服务器上部署项目：

```shell
git clone <your-repo-url>
cd FoodForAll
docker compose up --build -d
```

5. 打开服务器防火墙端口（如使用 ufw）：

```shell
sudo ufw allow 3000
sudo ufw allow 8000
```

完成后可通过服务器 IP 访问：

- http://<server-ip>:3000
- http://<server-ip>:8000

## Backend Api Doc

After starting the backend server, you can access the API documentation via http://localhost:8000/static/apidoc/index.html 

## Development and debugging environment setup

During testing and debugging, please change the `DEBUG` in `./server-app/FoodForAll/settings.py` to `True`. Because the operation during debugging needs to be done in DEBUG environment.

## Demo: Database after the first start of the backend service

The database is empty after starting the backend service for the first time. The backend service provides an interface in development mode for generating demo data.

**Note that the following process needs to be performed in the development environment, by calling the http://localhost:8000/init_database/ interface to generate the virtual data.**

This interface will empty the database and regenerate 50 mock users and 100 mock projects (please switch the actual database to a test database before calling to prevent data loss).

Please note that when generating the dummy items, the interface will call the api provided by paypal sandbox to request the product ids, so the interface will run very slowly, about 1 minute. Please be patient and do not refresh the page.

Also, the interface should not be called repeatedly within 5 minutes, otherwise the paypal sandbox may temporarily disable the api call and cause the interface to report an error. If you accidentally trigger the threshold for paypal to disable the call, don't worry, just wait 5 minutes and call the interface again.

The interface returns a json format, where `user_list` is a list of size 50*5, the 5 columns in the list are the initialised user: `uid`, `mail`, `password`, `encrypted_password`, `user_type`. If you are testing via the front end, use the `password` column as the user's password. If you are accessing the backend directly, use the `encrypted_password` column as the user password, as the password transfer encryption process is not applied when accessing the backend directly. `user_list` is also stored in `{project path}/debug/backend/init_database/init_database_user.csv` for testers to view.
