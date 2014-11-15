class AddYear2ToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :year2, :integer
  end
end
