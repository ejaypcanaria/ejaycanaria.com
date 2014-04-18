class CreateModelTags < ActiveRecord::Migration
  def change
    create_table :model_tags do |t|
      t.references :tag
      t.references :taggable, polymorphic: true
      t.timestamps
    end
  end
end
