class CreateSpins < ActiveRecord::Migration
  def change
    create_table :spins do |t|
      t.integer :fan_id
      t.integer :album_id
      t.timestamps :null=>false
    end
  end
end
