class AddSortTitleToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :sort_title, :text
  end
end
