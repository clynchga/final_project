class RemoveDate2FromRequests < ActiveRecord::Migration
  def change
    remove_column :requests, :date2, :text
  end
end
