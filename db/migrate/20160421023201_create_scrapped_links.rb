class CreateScrappedLinks < ActiveRecord::Migration
  def change
    create_table :scrapped_links do |t|
      t.string :link_name
      t.text :google_link
      t.text :scrapped_link
      t.timestamps null: false
    end
  end
end
