class AddNumPagesToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :num_pages, :integer
  end
end
