class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :instagram_id
      t.string :email
      t.string :full_name

      t.timestamps
    end
  end
end
