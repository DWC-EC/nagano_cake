class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer#ログインしているユーザーの情報
    @customer.update(customer_params)#下で指定したcustomer_paramsを受け取ってアップデート
    redirect_to customers_show_path
  end

  def confirm_withdraw

  end

  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)#会員退会
    reset_session#退会後ログアウト
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def customer_params#意図しないデータを登録しないようにする
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end
end

