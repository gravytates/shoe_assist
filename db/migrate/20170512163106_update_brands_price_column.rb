class UpdateBrandsPriceColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column(:brands, :price, :integer)
    add_column(:brands, :price, :string)
  end
end
