class CreateCOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :c_orders do |t|
      t.float :price
      t.integer :size
      t.string :side
      t.string :product_id
      t.string :time_in_force
      t.date :expire_time
      t.string :status

      t.timestamps
    end
  end
end
