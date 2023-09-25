class Admin::ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def index
    @item = Item.new
    @items = Item.all
  end

  def show
    @new_item = Item.new
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_items_path(item.id)
  end


  private
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image)  end
end
