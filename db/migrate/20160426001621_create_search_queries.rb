class CreateSearchQueries < ActiveRecord::Migration
  def change
    create_table :search_queries do |t|
      t.string :search

      t.timestamps null: false
    end
  end
end
