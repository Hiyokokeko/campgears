# Camp Gears

おすすめのキャンプギアや自分の愛用ギアを共有できる投稿サイトです。

![campgears](ホームの画像を貼り付け)

## URL
<デプロイ後URL貼り付け>
トップページの「**ゲストログイン**」をクリックするとメールアドレスやパスワードを入力せずにログインが可能です。

## 使用技術(あくまで予定)
### フロントエンド
  - bootstrap3
  - scss
  - JQuery

### バックエンド
  - Ruby  2.5.8
  - Rails 5.2.4

### サーバー
  - Nginx 1.16.1

### DB
  - MySQL 5.7

### インフラ・開発環境等
  - Docker/docker-compose
  - AWS（VPC, EC2, RDS, S3, Route 53, ALB, ACM）
  - CircleCI（CI/CD)
  - Capistrano3
  - RSpec
  - Rubocop

## アーキテクチャ
![aws構成図](https://user-images.githubusercontent.com/62534064/84650241-cff71400-af42-11ea-92b4-32a6ce468512.png)

## 機能一覧
### ユーザー機能
  - 新規登録
  - ログイン/ログアウト
  - ユーザー編集
### 記事投稿機能
  - 記事の編集/削除
  - 画像投稿
  - いいね・コメント
### 記事表示機能
- カテゴリー別表示
- 検索機能
- いいね数によるランキング表示
- ページネーション
