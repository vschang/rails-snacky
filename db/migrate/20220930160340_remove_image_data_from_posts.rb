class RemoveImageDataFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :image_data, :text
  end
end
