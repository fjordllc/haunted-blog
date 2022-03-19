class AddRandomEyecatchToBlogs < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :random_eyecatch, :boolean, null: false, default: false
  end
end
