class AddDatefieldToPages < ActiveRecord::Migration
  def change
    add_column :pages, :datefield, :text
  end
end
