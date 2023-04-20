# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## アプリケーション名
Patte à Patte (パット ア パット)

## アプリケーション概要
犬の飼い主同士が情報共有やコミュニティを作成することが出来る。

## URL
https://originalapp-39073.onrender.com

## テスト用アカウント

## 利用方法

## アプリケーションを作成した背景
初めて犬を飼うことになり、しつけ方法やドッグフード、動物病院や犬種にあった育て方など何が良くて何がダメなのか
分からず苦労した。初めてペットを飼う人たちが、育て方や日々の生活の中で気を付けることを共有出来たり、経験者の
方々からのアドバイスを手軽に貰えるような環境があれば良かったと思うことがあったため、本アプリの開発を決めた。

## 洗い出した要件
https://docs.google.com/spreadsheets/d/1Qo2gGtkPcVQnAIfGzUylmzpu9tJm6oa4jcbs6uJlLDc/edit#gid=982722306

## 実装した機能についての画像やGIFおよびその説明

## 実装予定の機能

## データベース設計

## 画面遷移図

## 開発環境
・フロントエンド
・バックエンド
・インフラ
・テスト
・VSCode
・タスク管理

## ローカルでの動作方法

## 工夫したポイント




## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| user_profile       | text   |             |
| dog_number         | string | null: false |

### Association

- has_many :posts
- has_many :messages
- has_many :room_users
- has_many :rooms, through: :room_users
- has_one_attached :image
- has_many :dog_profiles

## dog_profiles テーブル

| Column             | Type       | Options                       |
| ------------------ | ---------- | ----------------------------- |
| dog_breed          | string     |                               |
| dog_birthday       | date       |                               |
| dog_profile        | text       |                               |
| user               | references | null: false, foreign_key: true|

### Association
- belongs_to :user
- has_one_attached :image


## posts テーブル

| Column             | Type       | Options                       |
| ------------------ | -----------| ----------------------------- |
| tilte              | string     | null: false                   |
| content            | text       | null: false                   |
| category_id        | integer    | null: false                   |
| user               | references | null: false, foreign_key: true|

### Association
- belongs_to :user
- has_one_attached :image


## rooms テーブル

| Column             | Type       | Options                       |
| ------------------ | -----------| ----------------------------- |
| name               | string     | null: false                   |

### Association
- has_many :room_users, dependent: :destroy
- has_many :users, through: :room_users
- has_many :messages, dependent: :destroy


## room_users テーブル

| Column             | Type       | Options                       |
| ------------------ | -----------| ----------------------------- |
| room               | references | null: false, foreign_key: true|
| user               | references | null: false, foreign_key: true|

### Association
- belongs_to :room
- belongs_to :user


## messages テーブル

| Column             | Type       | Options                       |
| ------------------ | -----------| ----------------------------- |
| content            | string     |                               |
| room               | references | null: false, foreign_key: true|
| user               | references | null: false, foreign_key: true|

### Association
- belongs_to :room
- belongs_to :user
- has_one_attached :image
