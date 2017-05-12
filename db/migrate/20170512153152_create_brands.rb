class CreateBrands < ActiveRecord::Migration[5.1]
  def change
    create_table :brands do |b|
      b.string :name
      b.float :price

      b.timestamps
    end
  end
end
