# ohai

このクックブックは、ohaiで取得できるデータをリストするもので、クラウドベンダー固有のプラグインを利用したデータも取得できます。

前提条件
------------
- テストしたOSは、Debian 8.x,CentOS6,CentOS7,Ubuntu14.04 です。
- クラウドベンダー固有の情報を取得するために、以下のコマンドで hintを与える必要があります。下記の softlayer.json となっている処を AWSでは、ec2.json に変更すればAWSのプラグインが動作する様になります。 同様に gce, digital_ocean, azure など環境に合わせて変更します。

```
mkdir -p /etc/chef/ohai/hints && touch ${_}/softlayer.json
```


使い方
------------

CHEFの環境設定は必要ありません。対象サーバーにログインして、以下のコマンドで、Ohaiが取得できるデータをダンプできます。

```
# curl -L https://www.opscode.com/chef/install.sh | bash
# knife cookbook create dummy -o /var/chef/cookbooks
# cd /var/chef/cookbooks
# git clone https://github.com/takara9/ohai
# chef-solo -o ohai
```

実行結果例
-----------

```
[root@centos7 cookbooks]# chef-solo -o ohai
[2015-12-13T00:24:34+09:00] WARN: *****************************************
[2015-12-13T00:24:34+09:00] WARN: Did not find config file: /etc/chef/solo.rb, using command line options.
[2015-12-13T00:24:34+09:00] WARN: *****************************************
Starting Chef Client, version 12.5.1
[2015-12-13T00:24:39+09:00] WARN: Run List override has been provided.
[2015-12-13T00:24:39+09:00] WARN: Original Run List: []
[2015-12-13T00:24:39+09:00] WARN: Overridden Run List: [recipe[ohai]]
Compiling Cookbooks...
============================================
<中略>
[platform]= centos
[platform_version]= 7.1.1503
[platform_family]= rhel
<中略>
[softlayer]
    [public_fqdn]= centos7.takara.org
    [local_ipv4]= 10.132.253.30
    [public_ipv4]= 161.202.142.197
    [region]= tok02
    [instance_id]= 14532427
<中略>
[cloud]
    [public_ips]= ["161.202.142.197"]
    [private_ips]= ["10.132.253.30"]
    [public_ipv4]= 161.202.142.197
    [local_ipv4]= 10.132.253.30
    [public_hostname]= centos7.takara.org
    [provider]= softlayer
<中略>
```


License and Authors
-------------------

Authors: Maho Takara

License: see LICENCE file



