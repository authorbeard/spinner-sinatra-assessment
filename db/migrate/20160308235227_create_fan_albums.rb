class CreateFanAlbums < ActiveRecord::Migration
  def change
    create_table :fan_albums do |t|
      t.integer :fan_id
      t.integer :album_id
    end
  end
end
