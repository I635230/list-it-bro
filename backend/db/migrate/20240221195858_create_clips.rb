class CreateClips < ActiveRecord::Migration[7.0]
  def change
    create_table :clips, id: :string do |t|
      t.integer :broadcaster_id
      t.integer :creator_id
      t.integer :game_id
      t.string :language
      t.string :title
      t.datetime :clip_created_at
      t.string :thumbnail_url
      t.float :duration

      t.timestamps
    end
  end
end
