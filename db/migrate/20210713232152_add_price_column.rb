class AddPriceColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :animals, :price, :integer
  end
end
