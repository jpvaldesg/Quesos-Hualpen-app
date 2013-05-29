class CreateProcessors < ActiveRecord::Migration
  def change
    create_table :processors do |t|

      t.timestamps
    end
  end
end
