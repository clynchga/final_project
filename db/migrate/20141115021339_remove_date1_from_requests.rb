class RemoveDate1FromRequests < ActiveRecord::Migration
  def change
    remove_column :requests, :date1, :text
  end
end
