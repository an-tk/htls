class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :title
      t.integer :stars
      t.boolean :breakfast_included
      t.text :description
      t.float :price

      t.timestamps
    end
  end
end
