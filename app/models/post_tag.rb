class PostTag < ApplicationRecord
  belongs_to :post
  validates :tag, uniqueness: { scope: :post_id }, inclusion: { in: %w(alcohol beverage bread candy cereal chips chocolate cookies crackers dip frozen fruit gummies icecream nuts pastry spread),
    message: "%{value} is not a valid tag" }
end
