class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer#ログインしているユーザーの情報
    if @customer.update(customer_params)#下で指定したcustomer_paramsを受け取ってアップデート
      flash[:notice] = "登録情報の編集に成功しました。"
      redirect_to customers_show_path
    else
      flash.now[:notice] = "登録情報の編集に失敗しました。"
      render :edit
    end
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

