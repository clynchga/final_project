class AddImgUrlToPages < ActiveRecord::Migration
  def change
    add_column :pages, :img_url, :string
  end
end
