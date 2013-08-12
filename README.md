# Kosen Venture CMS
高専ベンチャー Contents Managemet System

## 概要
[高専ベンチャーのWebサイト](http://www.kosen-venture.com/)を管理するCMSとして開発しました．


## CMSの起動方法

### プロジェクトのclone
```sh
git clone https://github.com/falcon8823/KosenVenture-CMS.git
cd KosenVenture-CMS
bundle install --path .bundle/ --without production
```

### 送信元メールアドレスの設定
config/application.rb に記述されている，ADMIN_EMAIL定数に設定します．

### DBの設定

```sh
cp config/database.yml.example config/database.yml
# config/database.yml を編集してデータベースの設定に合わせます
```

### DBの初期化

```sh
bundle exec rake db:create
bundle exec rake db:migrate
```

### 初期管理ユーザの作成
<pre>
bundle exec rake db:seed
</pre>
を実行することで初期ユーザが作成されます．

* ログイン名：admin
* パスワード：admin

### サーバの起動

```sh
bundle exec rails s
```

これで、`http://localhost:3000/admin`にアクセスすると、管理ページのログイン画面にアクセスできます。


## License
* MIT License

## Copyright
&copy;  2013 Hayato OKUMOTO, All rights reserved.
