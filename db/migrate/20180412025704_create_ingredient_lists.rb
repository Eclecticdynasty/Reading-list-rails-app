class CreateIngredientLists < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredient_lists do |t|
        t.references :recipe, foreign_key: true
        t.references :ingredient, foreign_key: true
      t.timestamps
    end
  end
end
