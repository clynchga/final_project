class AddDay1ToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :day1, :integer
  end
end
