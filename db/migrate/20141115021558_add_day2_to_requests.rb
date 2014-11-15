class AddDay2ToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :day2, :integer
  end
end
