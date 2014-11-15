class AddYear1ToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :year1, :integer
  end
end
