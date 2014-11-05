class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :publication_id
      t.text :date
      t.integer :seq
      t.integer :ed

      t.timestamps
    end
  end
end
