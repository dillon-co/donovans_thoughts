class CreateScrappedLinks < ActiveRecord::Migration
  def change
    create_table :scrapped_links do |t|
      t.string :link_name
      t.text :scrapped_link
      t.text :returned_text

      t.timestamps null: false
    end
  end
end
