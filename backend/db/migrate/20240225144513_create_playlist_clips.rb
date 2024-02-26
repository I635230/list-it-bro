class CreatePlaylistClips < ActiveRecord::Migration[7.0]
  def change
    create_table :playlist_clips do |t|
      t.references :playlist, null: false, foreign_key: true
      t.references :clip, null: false, foreign_key: true

      t.timestamps
    end
    add_index :playlist_clips, [:playlist_id, :clip_id], unique: true
  end
end
