class AddAdoptionColumnToAnimals < ActiveRecord::Migration[6.1]
  def change
    add_column :animals, :adopted, :boolean
  end
end
