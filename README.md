# Show-kuzai (食材)
#### Show-kuzaiは「**冷蔵庫の中身からレシピを提案**」するアプリです

- 冷蔵庫の食材を使い切れず無駄にしてしまう事
- 家にあるものを把握しきれず何を買うべきか、何を作るべきかが決まらない

といった事が自分によくありました。同じ経験をされている方も多いかと思います。<br>
この問題を解決するべく、登録した食材からレシピを確認できる
###### 「**食材管理** + **レシピ提案**」アプリを開発いたしました。

## URL

## テスト用アカウント
メールアドレス： test@test.com
パスワード： test000
> 0は数字のゼロです

# 主な機能

#### ユーザー毎の冷蔵庫管理機能
- ログイン･ログアウト
- 食材登録
- 食材編集
- 調理完了時に自動で食材消費

#### ユーザ毎のレシピ提案機能
- 冷蔵庫の中身を参照してレシピを提案
- 古い食材を使用するレシピを優先的にピックアップ
- 提案レシピに「なにを消費できるか」表示（冷蔵庫の「たまねぎ」を使用できます）
- レシピ詳細ページに「何が足りないか」を表示(ボタン一つでお買い物リスト化)
- レシピ詳細ページの「調理完了」ボタンで自動で食材消費

#### お買い物メモ機能
- レシピに足りない食材をリスト化して表示
- 購入完了ボタンを押すと冷蔵庫に自動で登録

#### レシピ検索機能
- ジャンル(洋食、和食等)、使用食材名、レシピ名から検索可能


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
- has_many :ingredient, through: shopping_list_items



# SHOPPING_LIST_ITEMSテーブル

|column|type|option|
|------|----|------|
|shopping_list_id|references|null: false, foreign_key: true|
|ingredient_id|references|null: false, foreign_key: true|
|purchased|boolean|null: false, default: false|
|quantity|integer|任意|
||||
||ActiveHash||
|unit_id|integer|任意|


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