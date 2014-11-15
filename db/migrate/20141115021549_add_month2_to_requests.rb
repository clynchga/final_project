class AddMonth2ToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :month2, :integer
  end
end
