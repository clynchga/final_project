class AddMonth1ToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :month1, :integer
  end
end
