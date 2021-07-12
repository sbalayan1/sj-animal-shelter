class AddColumnTypeToAnimals < ActiveRecord::Migration[6.1]
  def change
    add_column(:animals, :species, :string)
  end
end
