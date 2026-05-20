# DB設計

# USERSテーブル

|column|type|option|
|------|----|------|
|name|string|null: false|
|email|string|null: false, unique: true|
|encrypted_password|string|null: false|
|admin|boolean|null: false, default: false|

## usersアソシエーション

- has_many :fridge_items
- has_many :cooking_histories
- has_many :shopping_lists


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
- has_many :shopping_lists


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

- belongs_to :user
- belongs_to :recipe

# SHOPPING_LISTSテーブル

|column|type|option|
|------|----|------|
|user_id|references|null: false, foreign_key: true|
|recipe_id|references|null: false, foreign_key: true|

## shopping_listsアソシエーション

- belongs_to :user
- belongs_to :recipe
- has_many :shopping_list_items, dependent: :destroy


# SHOPPING_LIST_ITEMSテーブル

|column|type|option|
|------|----|------|
|shopping_list_id|references|null: false, foreign_key: true|
|ingredient_id|references|null: false, foreign_key: true|
|purchased|boolean|null: false, default: false|

## shopping_list_itemsアソシエーション

- belongs_to :shopping_list
- belongs_to :ingredient


# ACTIVE_HASH

## status
- たっぷりある
- あとすこし
- 使い切った
__(statusで管理してDBから削除しない)__

## unit
- 個
- 本
- 枚
- 匹
- g
- ml
__(追加の可能性あり)__

## genre
- 和食
- 洋食
- 中華
- イタリアン
- エスニック