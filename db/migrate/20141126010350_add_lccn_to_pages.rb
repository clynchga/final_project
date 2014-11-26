class AddLccnToPages < ActiveRecord::Migration
  def change
    add_column :pages, :lccn, :text
  end
end
