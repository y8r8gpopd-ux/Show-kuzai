class ShoppingListsController < ApplicationController
  def index
  end

  def complete
    shopping_list = current_user.shopping_lists.find(params[:id])

    # チェックボックスでチェックされたものが配列で送られてくる
    purchased_item_ids = params[:purchased_item_ids] || []

    shopping_list.shopping_list_items.each do |item|

      if purchased_item_ids.include?(item.id.to_s)
        # 買った食材は購入済みへ(purchased = true)
        item.update(purchased: true)

        # 冷蔵庫に保存
        FridgeItem.create(
          user_id: current_user.id,
          ingredient_id: item.ingredient_id,
          purchased_at: Date.today,
          status_id: 1
        )

      end
    end

    # shopping_list_itemsが全て購入済みになったらshopping_listを破棄
    if shopping_list.shopping_list_items.all?(&:purchased)
      shopping_list.destroy
    end

    redirect_to root_path
  end

end
