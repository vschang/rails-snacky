class AddImageDataToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :image_data, :text
  end
end
