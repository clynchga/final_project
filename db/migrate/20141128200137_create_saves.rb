class CreateSaves < ActiveRecord::Migration
  def change
    create_table :saves do |t|
      t.integer :page_id
      t.integer :user_id
      t.text :note
      t.timestamps
    end
  end
end
