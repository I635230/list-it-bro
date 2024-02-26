class CreateClipTwitchIds < ActiveRecord::Migration[7.0]
  def change
    create_table :clip_twitch_ids do |t|
      t.references :clip, null: false, foreign_key: true
      t.string :clip_twitch_id, unique: true

      t.timestamps
    end
  end
end
