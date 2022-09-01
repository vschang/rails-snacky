class AddImageToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :image, :string, array: true, default: [] # add images column as array
  end
end
