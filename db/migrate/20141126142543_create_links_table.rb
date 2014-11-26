class CreateLinksTable < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :request_id
      t.integer :page_id

      t.timestamps

    end
  end
end
