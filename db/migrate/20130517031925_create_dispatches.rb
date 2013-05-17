class CreateDispatches < ActiveRecord::Migration
  def change
    create_table :dispatches do |t|
      t.string :direction
      t.string :description
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps
      t.date :final

      t.timestamps
    end
  end
end
