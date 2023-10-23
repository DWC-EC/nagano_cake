class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!#ログインしたユーザーのみこのコントローラーを実行可能

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end
end

