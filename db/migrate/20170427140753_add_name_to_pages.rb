class AddNameToPages < ActiveRecord::Migration[5.0]
  def change
    add_index :pages, :name
    add_index :pages, :parent_id
  end
end
