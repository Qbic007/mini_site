class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.string :name
      t.string :title
      t.text :content
      t.text :content_raw
      t.integer :parent_id

      t.timestamps
    end
  end
end
