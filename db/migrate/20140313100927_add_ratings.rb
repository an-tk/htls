class AddRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.text :comment
      t.integer :score
      t.references :user
      t.references :hotel
      t.timestamps
    end
  end
end
