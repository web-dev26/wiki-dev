class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
	t.string    :name
    t.string    :label
    t.text       :text_prime
    t.text       :text_convert
	t.integer  :parent_id
	t.timestamps null: false
    end
	add_index :pages, [ :name,  :parent_id ]
  end
end
