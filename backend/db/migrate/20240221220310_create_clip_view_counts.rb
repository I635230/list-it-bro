class CreateClipViewCounts < ActiveRecord::Migration[7.0]
  def change
    create_table :clip_view_counts do |t|
      t.references :clip, null: false, foreign_key: true
      t.integer :view_count

      t.timestamps
    end
  end
end
