class CreateCProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :c_products do |t|
      t.string :crypto
      t.float :price
      t.date :date

      t.timestamps
    end
  end
end
