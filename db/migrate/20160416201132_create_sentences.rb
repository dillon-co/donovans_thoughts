class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.string :input

      t.timestamps null: false
    end
  end
end
