class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.text :title
      t.text :state
      t.text :city
      t.text :lccn

      t.timestamps
    end
  end
end
