class CreateShelters < ActiveRecord::Migration[6.1]
  def change
    create_table :shelters do |t|
      t.string :name
      t.string :location_id
    end
  end
end
