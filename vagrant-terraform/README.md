# vagrant-terraform

この Vagrantfile は、Terraformによって IBM Cloud の仮想サーバーをプロビジョニングして、Ansibleで自動設定するためのワークステーション（仮想サーバー）を起動するためのものです。これを利用するためには、Vagrant と VirtualBox がインストールされたパソコンが必要です。


## インストールするパッケージ

vagrant up することで、次のパッケージがインストールされて、仮想サーバーが起動します。

* ansible
* python, python-pip
* unzip
* terraform
* terraform-provider for IBM Cloud
* 仮想サーバーの秘密鍵（認証鍵）
* IBM Cloud CLI (Git,Docker,Helm,kubectl,curl,IBM Cloud Developer Tools plugin, IBM Cloud Functions plugin, IBM Cloud Container Registry plugin, IBM Cloud Kubernetes Service plugin, sdk-gen plugin が含まれます)
* インスタンスの起動プロジェクト https://github.com/takara9/terraform-ibmcloud-vsi

仮想サーバーの秘密鍵は、ansible playbookによって /home/vagrant/keys/key に自動生成されます。


## 起動とログイン、初期動作確認

次のように起動して、ログイン後に、環境を確認できます。

~~~
$ git clone https://github.com/takara9/vagrant-terraform
$ cd vagrant-terraform
$ vagrant up
＜中略＞

$ vagrant ssh
＜中略＞

$ terraform --version
Terraform v0.12.28

$ ibmcloud --version
ibmcloud version 1.1.0+cc908fe-2020-04-29T04:06:12+00:00

$ ansible --version
ansible 2.9.9
~~~

## Terraform を使用して仮想サーバーを起動する


プロジェクトのディレクトリに移動して`terraform init`で環境設定を完了させる。

~~~
$ cd vsi
$ terraform init
~~~

実行前に `terraform plan` で、実行可能性の確認する。エラーが無ければ 適用へ進む。ここで、secret.tfvars は IBM Cloud のサービス利用資格情報の変数であり、ユーザー個別に取得してセットする必要がある。雛形は secret.tfvars.temp なのでファイル名を変更して編集してください。terraform.tfvarsは、プロジェクトの変数で、簡単な変更は、このファイルを編集する。

~~~
$ terraform plan --var-file /vagrant/secret.tfvars --var-file terraform.tfvars
~~~

IBM クラウドのインスタンスの作成

~~~
$ terraform apply --var-file /vagrant/secret.tfvars --var-file terraform.tfvars
~~~

インスタンスの表示

~~~
$ terraform show
~~~

インスタンスの削除

~~~
$ terraform destroy --var-file /vagrant/secret.tfvars --var-file terraform.tfvars
~~~












