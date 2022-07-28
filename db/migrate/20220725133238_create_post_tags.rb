class CreatePostTags < ActiveRecord::Migration[7.0]
  def change
    create_table :post_tags do |t|
      t.string :tag
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
