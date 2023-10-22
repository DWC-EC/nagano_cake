class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  enum payment_method: { credit_card: 0, transfer: 1 }

  validates :customer_id, :postage, :billing_amount, :payment_method, :postal_code, :address, :name, presence: true
end
