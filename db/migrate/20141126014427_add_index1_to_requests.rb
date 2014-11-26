class AddIndex1ToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :index1, :integer
  end
end
