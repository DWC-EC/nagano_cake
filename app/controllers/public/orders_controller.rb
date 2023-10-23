class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!#ログインしたユーザーのみこのコントローラーを実行可能

  def new
    @order = Order.new
    @customer = current_customer
  end

  def confirm #注文情報入力画面　Orderモデルに保存
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params) #ストロングパラメータ
    @order.customer_id = current_customer.id
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name + current_customer.first_name

    @total = 0
    @postage = 800
    @total_price = 0
  end

  def complete
  end

  def create#注文情報保存　OrderItemモデルに保存
    @order = Order.new(order_params) #ストロングパラメータ
    if @order.save #confirmを保存？
      #order_item(注文詳細)への保存　カートに入れた商品の種類毎にデータがあるのでeach
      current_customer.cart_items.each do |cart_item|
        @order_item = OrderItem.new
        @order_item.order_id =  @order.id #注文ID←(confirm 会員ID.送料.請求金額.支払方法.配送先)
        @order_item.item_id = cart_item.item_id #商品ID
        @order_item.amount = cart_item.amount #個数
        @order_item.price = (cart_item.item.price*1.1).floor #消費税込み価格
        @order_item.save #注文商品を保存
      end
      current_customer.cart_items.destroy_all #カートの中身を削除(cart_items_controller)
      redirect_to orders_complete_path
    else
      render :new
    end
  end

  def index
    @order = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.all
  end


  private
  def order_params #送料,支払方法,郵便番号,住所,名前,請求金額,会員ID
    params.require(:order).permit(:postage, :payment_method, :postal_code, :address, :name, :billing_amount, :customer_id)
  end
end
