class Item < ApplicationRecord
  has_one_attached :image

  def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end

  def  add_tax_price #消費税10%
    (self.price * 1.10).round
  end
end
