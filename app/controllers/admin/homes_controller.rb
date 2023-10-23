class Admin::HomesController < ApplicationController

  before_action :authenticate_admin!#ログインしたユーザーのみこのコントローラーを実行可能

  def top
    @orders = Order.page(params[:page]).per(10)
  end
end
