class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.integer :product_id
      t.integer :cocktail_id
      t.float :value
      t.timestamps null: false
    end
  end
end
