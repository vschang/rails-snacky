class AddLatToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :lat, :float
  end
end
