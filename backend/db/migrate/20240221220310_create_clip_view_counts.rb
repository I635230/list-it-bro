class CreateClipViewCounts < ActiveRecord::Migration[7.0]
  def change
    create_table :clip_view_counts do |t|
      t.string :clip_id, null: false
      t.integer :view_count

      t.timestamps
    end
    add_foreign_key :clip_view_counts, :clips
    add_index :clip_view_counts, :clip_id
  end
end
