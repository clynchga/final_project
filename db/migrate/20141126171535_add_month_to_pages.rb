class AddMonthToPages < ActiveRecord::Migration
  def change
    add_column :pages, :month, :integer
  end
end
