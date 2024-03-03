class CreateBroadcasters < ActiveRecord::Migration[7.0]
  def change
    create_table :broadcasters, id: false do |t|
      t.column :id, 'BIGINT PRIMARY KEY'
      t.string :login
      t.string :display_name
      t.string :profile_image_url

      t.timestamps
    end
  end
end
