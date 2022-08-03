class PostTag < ApplicationRecord
  belongs_to :post
  validates :tag, uniqueness: { scope: :post_id }, inclusion: { in: %w(chips chocolate alcohol gummies candy pastry),
    message: "%{value} is not a valid size" }
end
