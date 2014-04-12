class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :contents
      t.string :permalink, limit: 500
      t.string :status
      t.datetime :published_at
      t.belongs_to :user
      t.timestamps
    end

    add_index :blogs, [:permalink], unique: true
    add_index :blogs, [:user_id, :status]
  end
end
