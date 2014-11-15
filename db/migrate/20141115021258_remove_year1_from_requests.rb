class RemoveYear1FromRequests < ActiveRecord::Migration
  def change
    remove_column :requests, :year1, :text
  end
end
