class Public::HomesController < ApplicationController
  def top
    @item = Item.all
    @items = Item.order(created_at: :desc).limit(4)
  end

  def about
  end
end
