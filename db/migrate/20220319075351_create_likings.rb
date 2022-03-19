class CreateLikings < ActiveRecord::Migration[7.0]
  def change
    create_table :likings do |t|
      t.belongs_to :blog, null: false, foreign_key: true, index: false
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :likings, [:blog_id, :user_id], unique: true
  end
end
