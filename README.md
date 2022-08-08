# ubuntu-server-setup

安裝 Node.js 環境

```
$  sudo apt-get install curl
$  curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
$  sudo apt-get install nodejs
```

檢查 Node.js / NPM / Git 版本

```
$ node -v
$ npm -v
$ git --version
```

安裝 Nginx

```
$ apt-get install nginx
```

更新 Service apt-get
```
$ sudo apt-get update
```


安裝 Docker
```
$ sudo apt-get install docker.io
$ sudo apt-get install docker-compose
$ snap install docker 
```
將自己的使用者帳號加入至 docker 群組：
```
$ sudo usermod -aG docker root

```

檢查 Docker
```
$ service docker status
$ docker version
```

改權限
```
sudo chmod -R 777 file
```
