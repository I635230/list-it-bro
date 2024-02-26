class CreatePlaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :playlists, id: false do |t|
      t.column :id, 'BIGINT PRIMARY KEY'
      t.integer :creator_id
      t.string :title
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
