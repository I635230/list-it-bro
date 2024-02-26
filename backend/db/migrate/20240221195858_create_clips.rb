class CreateClips < ActiveRecord::Migration[7.0]
  def change
    create_table :clips do |t|
      t.integer :broadcaster_id
      t.integer :creator_id
      t.integer :game_id
      t.string :language
      t.string :title
      t.datetime :clip_created_at
      t.string :thumbnail_url
      t.float :duration
      t.integer :order, null: false, default: 1

      t.timestamps
    end
  end
end
