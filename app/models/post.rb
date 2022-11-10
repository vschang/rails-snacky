class Post < ApplicationRecord
  has_many_attached :images, dependent: :destroy
  mount_uploaders :image, ImageUploader
  belongs_to :user
  has_many :post_likes, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :saved_posts, dependent: :destroy
  validates :title, :rating, :country, :review, :brand, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  paginates_per 5
  validates :image, file_size: { less_than_or_equal_to: 5.megabytes },
              file_content_type: { allow: ['image/jpeg', 'image/png', 'image/gif', 'image/webp', 'image/heic'] }


  def country_name
    ISO3166::Country[country]
  end

  include PgSearch::Model
  pg_search_scope :global_search,
                  against: %i[title brand],
                  using: {
                    tsearch: { prefix: true }
                  }
end
