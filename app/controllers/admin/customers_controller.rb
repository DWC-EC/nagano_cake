class Admin::CustomersController < ApplicationController

  before_action :authenticate_admin!#ログインしたユーザーのみこのコントローラーを実行可能

  def index
    @customer = Customer.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "編集が完了しました。"
      redirect_to admin_customer_path(@customer.id)
    else
      flash.now[:alert] = "編集に失敗しました。"
      render :edit
    end
  end


  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :is_deleted)
  end
end
