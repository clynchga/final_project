class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.text :url
      t.text :state
      t.text :lccn
      t.text :andtext
      t.text :ortext
      t.text :phrasetext
      t.text :date1
      t.text :date2
      t.text :datefiltertype

      t.timestamps
    end
  end
end
