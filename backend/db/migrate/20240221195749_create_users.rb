class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: false do |t|
      t.column :id, 'BIGINT PRIMARY KEY'
      t.string :name

      t.timestamps
    end
  end
end
