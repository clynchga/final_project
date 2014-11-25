class DropTable < ActiveRecord::Migration
  def change
  	drop_table(:requests_pages)
  end
end
