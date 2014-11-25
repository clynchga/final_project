class CreateRequestsPages < ActiveRecord::Migration
  def change
    create_table :requests_pages, :id => false do |t|
    	t.column "request_id", :integer, :null => false
    	t.column "page_id", :integer, :null => false
    end
  end
end
