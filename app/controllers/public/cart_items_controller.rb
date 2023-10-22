class Public::CartItemsController < ApplicationController
  
  before_action :authenticate_customer!, only: [:create]
  
  def index
    @cart_items = current_customer.cart_items
    @total = 0
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  def create
    @cart_item = CartItem.new(cart_item_params)#新しく作られるデータ
    @cart_item.customer_id = current_customer.id

    cart_item = CartItem.find_by(customer_id: current_customer.id,item_id: params[:cart_item][:item_id])
    #アイテムが存在するか確認　客idの中のログインしている客idと[:カートアイテム]の[:アイテムid]
    if cart_item #もう存在しているデータ
      cart_item.amount += params[:cart_item][:amount].to_i#存在しているデータに　[:カートアイテム]の[:数]を足す
      cart_item.update(amount: cart_item.amount)#存在しているデータに数追加するのでupdate
      redirect_to cart_items_path(@cart_item.id)
    else
      @cart_item.save #もしカートに同じ商品がなかったら新しく作られたデータを保存(save)
      redirect_to cart_items_path(@cart_item.id)
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
