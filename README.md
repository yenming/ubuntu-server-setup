# ubuntu-server-setup

# 機台環境

安裝 Node.js 環境

```
$  apt-get install curl
$  curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
$  apt-get install nodejs
$  apt install git
```

檢查 Node.js / NPM / Git 版本

```
$ node -v
$ npm -v
$ git --version
```

更新 Service apt-get
```
$ apt-get update
```

# Nginx

安裝 Nginx

```
$ apt-get install nginx
```


修改 Nginx 的設定檔

```
$ vim /etc/nginx/sites-enabled/default.conf

```



改成 Domain 名稱(server_name example.com)
```
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    
    root /var/www/html;
    
    index index.html index.htm index.nginx-debian.html
    # 改成 Domain 名稱(server_name example.com)
    server_name _;
    
    location / {
        try_files $uri $uri/ =404;
    }
}
```



把 location / {} 的大括號中換成以下內容

```

# 反向代理到同一台主機的 3000 Port
proxy_pass http://localhost:3000;

# 把 IP、Protocol 等 header 都一起送給反向代理的 server
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header X-Forwarded-Proto $http_x_forwarded_proto;

```


存擋以後記得重啟 Nginx

```

$ service nginx reload

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

# Let's Encrypt  SSL 使用方式

Step 1：下載和安裝Certbot套件。

```

$ sudo apt-get update -y

```

Step 2：安裝Certbot套件 for Nginx伺服器。

```

$ sudo apt-get install certbot python3-certbot-nginx -y

```

Step 3：設定好DNS的A Record和編輯好網頁伺服器的Config檔。

Step 4：編輯網頁伺服器的設定檔，以讓SSL憑證能正常簽發 for Nginx伺服器。

Step 4-1：編輯Nginx設定檔，這邊的config檔路徑和名稱會跟大家不一樣，請自行設定你主機原有的config檔。以下指令筆者用Vim編輯器來設定自己的config檔。

```
$ sudo vim /etc/nginx/sites-available/<nginx-config>

```

Step 4-2：Certbot工具需要能在Nginx設定檔的『server』區塊中辨識到『server_name』的域名和你要申請的憑證一樣，比如筆者要申請的憑證為『example.com』和『www.example.com』，那config會是如下：

```
server {
    listen 80;
    listen [::]:80;
    ## Certbot會看的設定如下『server_name』
    server_name example.com www.example.com;
    root /var/www/kjnotes;
    
    # ...

}

```

Step 4-3：測試Nginx設定檔，查看執行有沒有錯誤及重新載入Nginx的config檔。

```
$ sudo nginx -t
$ sudo systemctl reload nginx

```

Step 5：開始為域名申請SSL憑證。

Step 5-1：輸入以下指令來申請憑證，分別輸入你的電子郵件，同意Let's Encrypt相關的許可協議，及輸入要申請憑證的域名，域名的格式為『-d <第一組域名> -d <第二組域名> -d <第三組域名>』以此類推。

**下面的指令，請務必要將『email@example.com』更換成你的電子郵件地址，和『example.com』更換成要申請憑證的域名。

**填入Email的用意，若日後遇到憑證有異常（比如誤發，憑證機構需要撤銷受影響的憑證），那Let's Encrypt是會主動發Email通知，讓你提早知道憑證需要重新申請。

**下面是使用『certbot --nginx』方式取得憑證的指令，這指令可以讓Certbot工具協助設定Nginx的config檔：

```

$ sudo certbot --nginx --email email@example.com --agree-tos -d example.com -d www.example.com

```

**如果只需要申請憑證，那需加入『certonly』，指令為『certbot certonly --nginx』，後面的部分需自己手動設定Nginx的config檔；本文教學是使用下面這串指令：

```
$ sudo certbot certonly --nginx --email email@example.com --agree-tos -d example.com -d www.example.com

```
Step 5-2：申請過程可能會詢問一些問題，比如下面會詢問你是否需要收到Let's Encrypt組織相關的郵件，筆者這邊是選擇『n』。



Step 5-3：憑證申請成功後，會出現『Congratulations!』的訊息，而申請成功的憑證會存放在『/etc/letsencrypt/live/example.com』目錄中。

**若憑證申請失敗，請先找出問題，因Let's Encrypt憑證在一定時間內申請會有次數限制，故先加入--dry-run指令來進行測試：

```

$ sudo certbot certonly --nginx --email email@example.com --agree-tos -d example.com -d www.example.com --dry-run

```

Step 6：網頁伺服器的HTTPS協定的設定 for  Nginx伺服器。
Step 6-1：編輯Nginx設定檔，這邊的config檔路徑和名稱會跟大家不一樣，請自行設定你主機原有的config檔。以下指令筆者用Vim編輯器來設定自己的config檔。

```
$ sudo vim /etc/nginx/sites-available/<nginx-config>

```
Step 6-2：設定Nginx HTTP自動轉址至HTTPS。
**下面的範例，請自行將『example.com』替換成你自己的域名。

```
server {
    listen 80;
    listen [::]:80;
    server_name example.com www.example.com;
    return 301 https://example.com$request_uri;
}

```
Step 6-3：配置申請好的SSL憑證。

**下面的範例請自行將『root /var/www/example』替換至Nginx存放網頁的根目錄，及『example.com』替換成你自己的域名。

```
#HTTPS-有www轉址到沒有www
server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name www.example.com;
    ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;
    ssl_ecdh_curve X25519:secp384r1;
    ssl_session_cache shared:SSL:50m;
    ssl_session_timeout 1440m;
    ssl_session_tickets off;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers TLS13-AES-256-GCM-SHA384:TLS13-CHACHA20-POLY1305-SHA256:TLS13-AES-128-GCM-SHA256:TLS13-AES-128-CCM-8-SHA256:TLS13-AES-128-CCM-SHA256:EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+ECDSA+AES128:EECDH+aRSA+AES128:RSA+AES128:EECDH+ECDSA+AES256:EECDH+aRSA+AES256:RSA+AES256:EECDH+ECDSA+3DES:EECDH+aRSA+3DES:RSA+3DES:!MD5;
    ssl_prefer_server_ciphers on;
    ssl_stapling on;
    ssl_stapling_verify on;
    ssl_trusted_certificate /etc/letsencrypt/live/example.com/chain.pem;
    add_header Strict-Transport-Security "max-age=31536000; preload";
    return 301 https://example.com$request_uri;
}

#HTTPS-沒有www-最終網址
server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name example.com;
    root /var/www/html;
    ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;
    ssl_ecdh_curve X25519:secp384r1;
    ssl_session_cache shared:SSL:50m;
    ssl_session_timeout 1440m;
    ssl_session_tickets off;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers TLS13-AES-256-GCM-SHA384:TLS13-CHACHA20-POLY1305-SHA256:TLS13-AES-128-GCM-SHA256:TLS13-AES-128-CCM-8-SHA256:TLS13-AES-128-CCM-SHA256:EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+ECDSA+AES128:EECDH+aRSA+AES128:RSA+AES128:EECDH+ECDSA+AES256:EECDH+aRSA+AES256:RSA+AES256:EECDH+ECDSA+3DES:EECDH+aRSA+3DES:RSA+3DES:!MD5;
    ssl_prefer_server_ciphers on;
    ssl_stapling on;
    ssl_stapling_verify on;
    ssl_trusted_certificate /etc/letsencrypt/live/example.com/chain.pem;
    add_header Strict-Transport-Security "max-age=31536000; preload";
    
    # ...

}

```




Step 6-4：測試Nginx設定檔，查看執行有沒有錯誤及重新載入Nginx的config檔。

```
$ sudo nginx -t
$ sudo systemctl reload nginx

```

Step 7：檢查Certbot工具是否能自動更新Let's Encrypt憑證。

Let's Encrypt簽發的憑證有效期為90天，也就是說網站每接近3個月都需要重新更新一次憑證，Certbot工具有提供自動更新憑證的服務，檢查頻率為每日兩次，若憑證有效期還有30天以上不會更新憑證，僅在小於30天才會自動更新憑證。以下指令可查看certbot.timer服務運行狀態：
```

$ sudo systemctl status certbot.timer

```




Step 7-1：若需要測試憑證的更新，可使用Certbot指令執行憑證的更新。

```
$ sudo certbot renew --dry-run

```



Step 7-2：若要查看主機有申請了哪些域名的憑證，及到期日期和天數，可使用以下指令：

```
$ sudo certbot certificates

```

Step 8：使用『--dry-run』指令則可使用測試環境。
**若憑證申請失敗，請勿再繼續申請，因Let's Encrypt憑證在一定時間內申請會有次數限制，Certbot有提供『--dry-run』指令讓憑證的申請可以先在測試環境進行測試，雖然測試環境也有次數限制，但提供憑證申請的次數更多，故可以先找出憑證申請失敗的原因，並將其改善，及再次使用測試環境申請確定沒問題後，才使用一般方式申請憑證。

Step 8-1：若需使用測試環境，申請憑證的指令中只需帶有『--dry-run』，即可使用測試環境。

```
$ sudo certbot certonly --nginx --email email@example.com --agree-tos -d example.com -d www.example.com --dry-run

```

Step 8-2：如下面測試環境所示，可看到憑證申請失敗的Detail原因為『Timeout during connect (likely firewall problem)』可能為防火牆造成的例子。
**請善用關鍵字並配合搜尋引擎以搜尋網路資料來解決憑證無法申請順利的原因。

Step 8-3：若有將問題修正好，比如筆者已將防火牆問題處理好，則可看到『The dry run was successful.』成功的訊息，就能回到上面的第三部分教學以完成憑證的申請。


參考資料：https://www.kjnotes.com/devtools/62



#檢查EJS 的方法

從項目根目錄中的命令行運行以檢查項目中的所有 ejs 文件。

```
$ npx ejslint **/*.ejs
```


