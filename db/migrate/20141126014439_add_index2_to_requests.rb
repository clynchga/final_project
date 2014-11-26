class AddIndex2ToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :index2, :integer
  end
end
