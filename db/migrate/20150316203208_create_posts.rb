class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :cid
      t.belongs_to :user, index: true
      t.string :link
      t.text :body

      t.timestamps null: false
    end
    add_foreign_key :posts, :users
  end
end
