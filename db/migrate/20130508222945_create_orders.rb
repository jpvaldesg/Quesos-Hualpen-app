class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :arrivalDate
      t.time :arrivalTime
      t.string :rut
      t.string :addressId
      t.date :orderDate
      t.integer :sku
      t.decimal :qty
      t.string :unit
      t.string :state

      t.timestamps
    end
  end
end
