class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  def  add_tax_price #消費税10%
    (price * 1.1).floor
  end
  

end
