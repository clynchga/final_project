class RemoveDatefiltertypeFromRequests < ActiveRecord::Migration
  def change
    remove_column :requests, :datefiltertype, :text
  end
end
