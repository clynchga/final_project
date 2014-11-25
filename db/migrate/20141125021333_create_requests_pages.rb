class CreateRequestsPages < ActiveRecord::Migration
  def change
    create_table :requests_pages do |t|
      t.integer :request_id
      t.integer :page_id
    end
  end
end
