class AddSecretToBlogs < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :secret, :boolean, null: false, default: false
  end
end
