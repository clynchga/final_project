class AddDayToPages < ActiveRecord::Migration
  def change
    add_column :pages, :day, :integer
  end
end
