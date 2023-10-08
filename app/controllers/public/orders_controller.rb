class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name + current_customer.first_name
    @order.payment_method = params[:order][:payment_method]
    @total = 0
    @postage = 800
    @total_price = 0

  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.save
    current_member.cart_items.destroy_all 
    redirect_to orders_complete_path
  end

  def index

  end

  def show

  end


  private
  def order_params
    params.require(:order).permit(:postage, :payment_method, :postal_code, :address, :name)
  end
end
