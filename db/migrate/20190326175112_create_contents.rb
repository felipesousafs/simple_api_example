class CreateContents < ActiveRecord::Migration[5.2]
  def change
    create_table :contents do |t|
      t.string :text
      t.references :page, foreign_key: true
      t.references :content_type, foreign_key: true

      t.timestamps
    end
  end
end
