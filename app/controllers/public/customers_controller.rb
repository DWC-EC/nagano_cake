class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.all
  end

  def edit
    @customer = Customer.find(params[:id])
  end
end
