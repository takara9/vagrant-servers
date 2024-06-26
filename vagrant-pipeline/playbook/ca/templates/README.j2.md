
## 1.プライベート認証局を立ち上げるには、CAルート証明書を作成します。


### 1.1. 認証局のディレクトリへ移動

~~~
cd {{ ca_home }}
~~~

### 1.2. ルート証明書の生成

ここでパスフレーズの入力が要求される。ここで入力したパスフレーズは署名する時に必要となるので、メモしておく。パスフレーズは半角英数字の文字列でよい。apple123 や banana987 など。

~~~
openssl req -new -x509 -extensions v3_ca -keyout certs/cakey.pem -out certs/cacert.pem -days 3650 -subj "/C=JP/ST=Tokyo/L=Nihombash/O=TakaraSign"
~~~



## 2.プライベート認証局に証明書署名要求(CSR)を作成するには


### 2.1. ホームディレクトリで作業する

CSR作成用のディレクトリをCNで作成する。
ここでは、CNにregi.rat.local を使用する。

~~~
mkdir regi.rat.local
cd regi.rat.local
~~~

### 2.2. キーを作成する

CN名で鍵を作る。

~~~
openssl genrsa -des3 -out regi.rat.local.key.encrypted 2048
~~~


### 2.3. 暗号を解いて平文にする

~~~
openssl rsa -in regi.rat.local.key.encrypted -out regi.rat.local.key
~~~


### 2.4. CSRを作成する

ここでCN=にTLS暗号対象のドメイン名を設定する。ここでは regi.rat.local とする

~~~
openssl req -new -key regi.rat.local.key -out regi.rat.local.csr -subj "/C=JP/ST=Tokyo/L=Nihombash/O=TakaraSign/CN=regi.rat.local"
~~~


## 3. プライベート認証局による署名


### 3.1. CSRからの自己署名証明書の作成

パスフレーズの要求されるので、ルート証明書を作成した時のパスフレーズをインプットする。

~~~
openssl ca -in regi.rat.local.csr 
~~~


### 3.2 プライベート認証局署名証明書の取得

{{ ca_home }}/newcertsのディレクトリ下に、シリアル番号で生成されるので、コピーする。

~~~
cp {{ ca_home }}/newcerts/01.pem regi.rat.local.crt
~~~


これで、プライベート認証局署名済み証明書と、キーが作成できた。

* regi.rat.local.crt
* regi.rat.local.key

