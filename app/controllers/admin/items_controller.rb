class Admin::ItemsController < ApplicationController

  before_action :authenticate_admin!#ログインしたユーザーのみこのコントローラーを実行可能

  def new
    @item = Item.new
  end

  def index
    @item = Item.page(params[:page]).per(10)
  end

  def show
    @item = Item.find(params[:id])

  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "登録に成功しました。"
      redirect_to admin_item_path(@item.id)
    else
      flash.now[:alert] = "登録に失敗しました。"
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "編集に成功しました。"
      redirect_to admin_item_path(@item.id)
    else
      flash.now[:alert] = "登録に失敗しました。"
      render :edit
    end
  end


  private
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image)
  end
end
