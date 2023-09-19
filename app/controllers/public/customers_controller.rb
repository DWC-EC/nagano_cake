class Public::CustomersController < ApplicationController
  def show

  end

  def edit

  end

  def update
    @customers = Customer.find(params[:id])
    @customers.update
    redirect_to customers_show_path
  end
end

