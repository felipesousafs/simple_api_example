class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.string :link
      t.references :page, foreign_key: true

      t.timestamps
    end
  end
end
