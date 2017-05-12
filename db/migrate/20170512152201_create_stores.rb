class CreateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :stores do |s|
      s.string :name

      s.timestamps
    end
  end
end
