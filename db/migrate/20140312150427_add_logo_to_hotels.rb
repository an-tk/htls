class AddLogoToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :logo, :string
  end
end
