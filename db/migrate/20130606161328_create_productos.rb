class CreateProductos < ActiveRecord::Migration
  def change
    create_table :productos do |t|
      t.integer :sku
      t.string :descripcion
      t.float :precio
      t.date :desde
      t.date :hasta

      t.timestamps
    end
  end
end
