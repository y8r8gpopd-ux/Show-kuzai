# DB設計

# USERSテーブル

|column|type|option|
|------|----|------|
|name|string|null: false|
|email|string|null: false, unique: true|
||||
||ActiveHash|
|encrypted_password|string|null: false|

## usersアソシエーション

- has_many :fridge_items
- has_many :cooking_histories


# FRIDGE_ITEMSテーブル

|column|type|option|
|------|----|------|
|user_id|references|null: false, foreign_key: true|
|ingredient_id|references|null: false, foreign_key: true|
|purchased_at|date|null: false|
|quantity|integer|任意|
||||
||ActiveHash||
|unit_id|integer|任意|
|status_id|integer|null: false, default: 1(購入時は１)|

## fridge_itemsアソシエーション

- belongs_to :user
- belongs_to :ingredient


# RECIPESテーブル

|column|type|option|
|------|----|------|
|name|string|null: false|
|how_to_cook|text|null: false|
||||
||ActiveHash||
|genre_id|integer|null: false|
||ActiveStorage||
|image||(バリデーションで必須にする)|

## recipesアソシエーション

- has_many :ingredients, through: recipe_ingredients
- has_many :recipe_ingredients
- has_many :cooking_histories


# INGREDIENTSテーブル(食材マスタ)

|column|type|option|
|------|----|------|
|name|string|null: false, unique: true|

## ingredientsアソシエーション

- has_many :recipes, through: recipe_ingredients
- has_many :recipe_ingredients
- has_many :fridge_items


# RECIPE_INGREDIENTSテーブル

|column|type|option|
|------|----|------|
|recipe_id|references|null:false,  foreign_key: true|
|ingredient_id|references|null: false, foreign_key: true|
|quantity|integer|null: false|
||||
||ActiveHash||
|unit_id|integer|null: false|

## recipe_ingredientsアソシエーション

- belongs_to :recipe
- belongs_to :ingredient


# COOKING_HISTORIESテーブル

|column|type|option|
|------|----|------|
|user_id|references|null: false, foreign_key: true|
|recipe_id|references|null: false, foreign_key: true|
|cooked_at|date|null: false|

- belongs_to :user
- belongs_to :recipe


# ACTIVE_HASH

## status
- plenty (買ったばかり)
- little (あとすこし)
- used_up (使い切った！)
__(statusで管理してDBから削除しない)__

## unit
- 個
- 本
- 枚
- 匹
- g
- ml
__(追加の可能性あり)__