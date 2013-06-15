class AddCostAndPriceToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :cost, :float
    add_column :orders, :price, :float
  end
end
