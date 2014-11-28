class AddOcrTextToPages < ActiveRecord::Migration
  def change
    add_column :pages, :ocr_text, :text
  end
end
