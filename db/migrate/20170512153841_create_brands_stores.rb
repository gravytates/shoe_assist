class CreateBrandsStores < ActiveRecord::Migration[5.1]
  def change
    create_table :brands_stores do |b|
      b.integer :brand_id
      b.integer :store_id

      b.timestamps
    end
  end
end
