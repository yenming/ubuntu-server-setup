# ubuntu-server-setup

安裝 Node.js 環境

```
$  apt-get install curl
$  curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
$  apt-get install nodejs
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
$ apt-get update
```


安裝 Docker
```
$ apt-get install docker.io
$ apt-get install docker-compose
$ snap install docker 
```
將自己的使用者帳號加入至 docker 群組：
```
$ usermod -aG docker root

```

檢查 Docker
```
$ service docker status
$ docker version
```

刪除docker 所有容器(大招刪光光歸0用)
```
$  docker stop $(docker ps -aq) && docker rm $(docker ps -aq) && docker rmi $(docker images -q)
```

進入docker容器
```
$  docker exec -it [container id ] /bin/bash
```

重啟docker容器
```
$  docker restart [container id ]
```

運行docker容器 啟動/關閉/暫停
```
$  docker-compose up
$  docker-compose down
$  docker-compose stop [container id ]
```

刪除docker容器
```
$  docker rm [container id ]
```

刪除沒有被使用的docker容器
```
$  docker system prune
```

改權限
```
$  sudo chmod -R 777 file
```


查詢 PID
```
$  sudo lsof -i:port號
```

清除 PID
```
$  kill PID號碼
```
