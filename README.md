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


## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| user_profile       | text   |             |
| dog_breed          | string |             |
| dog_number         | string |             |
| dog_birthday       | date   |             |
| dog_profile        | text   |             |

### Association

- has_many :posts
- has_many :messages
- has_many :room_users
- has_many :rooms, through: :room_users


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
