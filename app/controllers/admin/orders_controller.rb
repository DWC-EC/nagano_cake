class Admin::OrdersController < ApplicationController
end

def show
  @order = Order.find(params[:id])
  @order_items = @order.order_item
end