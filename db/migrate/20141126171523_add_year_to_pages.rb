class AddYearToPages < ActiveRecord::Migration
  def change
    add_column :pages, :year, :integer
  end
end
