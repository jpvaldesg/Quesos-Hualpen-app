class CreateReservas < ActiveRecord::Migration
  def change
    create_table :reservas do |t|
      t.string :sku
      t.integer :qty

      t.timestamps
    end
  end
end
