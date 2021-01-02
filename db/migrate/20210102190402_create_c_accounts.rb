class CreateCAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :c_accounts do |t|
      t.string :currency
      t.float :balance
      t.float :hold
      t.string :available
      t.string :float

      t.timestamps
    end
  end
end
