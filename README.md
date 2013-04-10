# KV CMS
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

## History
* v0.0.1(2013/04/06)
	* 新規リリース
	* KV専用バージョン
	* シンプルなツリー構造のサイトを構成可能(ex: /about, /events/tour13)
	* ページはHTMLソースで記述可能
	* レイアウトはファイルを差し替える事で可能（Web上からは不可）
	* お問い合わせフォームが利用可能
	* 以下の管理が可能
		* ページ管理
		* ページカテゴリ管理
		* 編集ユーザ管理

## License
* MIT License

## Copyright
&copy;  2013 Hayato OKUMOTO, All rights reserved.
