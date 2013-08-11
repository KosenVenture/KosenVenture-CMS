# Kosen Venture CMS
高専ベンチャー Contents Managemet System

## 概要
[高専ベンチャーのWebサイト](http://www.kosen-venture.com/)を管理するCMSとして開発しました．

## 初期設定

### 送信元メールアドレスの設定
config/application.rb に記述されている，ADMIN_EMAIL定数に設定します．

### 初期管理ユーザの作成
<pre>
rake db:seed
</pre>
を実行することで初期ユーザが作成されます．

* ログイン名：admin
* パスワード：admin

## License
* MIT License

## Copyright
&copy;  2013 Hayato OKUMOTO, All rights reserved.
