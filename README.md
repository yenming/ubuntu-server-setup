# ubuntu-server-setup

# 機台環境

安裝 Node.js 環境

```
$  apt-get install curl
$  curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
$  apt-get install nodejs
$  apt install git
```

檢查 Node.js / NPM / Git 版本

```
$ node -v
$ npm -v
$ git --version
```

# Nginx

安裝 Nginx

```
$ apt-get install nginx
```

更新 Service apt-get
```
$ apt-get update
```


# Docker

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

啟動docker
```
$ systemctl start docker
```

#常用指令

改權限
```
$  sudo chmod -R 777/755 file
```


查詢 PID
```
$  sudo lsof -i:port號
```

清除 PID
```
$  kill PID號碼
```



ps ：將某個時間點的程序運作情況擷取下來

```
$ ps aux :觀察系統所有的程序資料 
$ ps -lA :也是能夠觀察所有系統的資料
$ ps axjf :連同部分程序樹狀態
```

選項與參數：

```
-A ：所有的 process 均顯示出來，與 -e 具有同樣的效用；
-a ：不與 terminal 有關的所有 process ；
-u ：有效使用者 (effective user) 相關的 process ；
x ：通常與 a 這個參數一起使用，可列出較完整資訊。
```

輸出格式規劃：
```

l ：較長、較詳細的將該 PID 的的資訊列出；
j ：工作的格式 (jobs format)
-f ：做一個更為完整的輸出。
```

使用 ssh 複製或上傳檔案

```
將 檔案/資料夾 從遠端 Ubuntu 機複製至本地(scp)
$ scp -r ubuntu@[ip]:/home/ubuntu/code ./
將 檔案/資料夾 從本地複製至遠端 Ubuntu 機(scp)
$ scp -r code ubuntu@[ip]:/home/ubuntu/
```

檔案連結

```
$ ln -sf [source_folder] [target_folder]
ex:source 就是你 root/data, target 就是你要放的 folder (eg. /var/www/hozi-project/data)

```


# 簡易防火牆設置ufw


安裝

```

$ apt-get install ufw

```

設定防火牆預設規則

```
$ ufw default allow # 預設允許
$ ufw default deny # 預設封鎖

```

允許/封鎖通訊埠（port）

```

允許 SSH port
$ ufw allow ssh/sudo ufw allow 22

允許或封鎖其他的 port：
$ ufw allow 80 # 允許 80
$ ufw allow 443 # 允許 443
$ ufw deny 3389 # 封鎖 3389
$ ufw deny 21 # 封鎖 21

一次允許一個範圍的 port：
$ ufw allow 6000:6007/tcp # 允許 TCP 6000~6007
$ ufw allow 6000:6007/udp # 允許 UDP 6000~6007
```

開啟/關閉/重設防火牆

```

$ ufw enable # 啟用防火牆
$ ufw disable # 停用防火牆
$ ufw reset # 重啟防火牆

```

查看目前設了什麼規則

```
$ ufw status numbered

```


