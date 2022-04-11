# README

This README would normally document whatever steps are necessary to get the
application up and running.

# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| name               | string | null: false |
| profile            | text   | null: false |
| occupation         | text   | null: false |
| position           | text   | null: false |

### Association (users)

- has_many : prototypes
- has_many : comments

## prototypes テーブル

| Column      | Type      | Options                         |
| ------      | ------    | -----------                     |
| title       | string    | null: false                     |
| catch_copy  | text      | null: false                     |
| concept     | text      | null: false                     |
| user        | reference | null: false, foreign_key: true  |


### Association (prototypes)

- belongs_to : user
- has_many : comments

## comments テーブル

| Column    | Type      | Options                         |
| ------    | ------    | -----------                     |
| content   | string    | null: false                     |
| prototype | reference | null: false, foreign_key: true  |
| user      | reference | null: false, foreign_key: true  |

### Association (comments)

- belongs_to : user
- belongs_to : prototype
