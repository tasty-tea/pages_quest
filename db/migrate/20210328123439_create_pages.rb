class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.string :name
      t.string :head
      t.text :body
      t.string :path
      t.integer :nesting
      t.integer :page_id, index: true

      t.timestamps
    end
  end
end
