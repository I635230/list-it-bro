class CreateTwitchUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :twitch_users, id: false do |t|
      t.column :id, 'BIGINT PRIMARY KEY'
      t.string :name
      t.string :profile_image_url

      t.timestamps
    end
  end
end
