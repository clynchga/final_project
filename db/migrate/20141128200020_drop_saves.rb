class DropSaves < ActiveRecord::Migration
  def change
  	drop_table :saves
  end
end
