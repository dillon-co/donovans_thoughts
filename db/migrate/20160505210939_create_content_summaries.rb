class CreateContentSummaries < ActiveRecord::Migration
  def change
    create_table :content_summaries do |t|
      t.text :original_content
      t.text :summary
      t.integer :search_query_id, foreign_key: true

      t.timestamps null: false
    end
  end
end
