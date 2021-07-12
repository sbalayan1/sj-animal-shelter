class CreateAdoptions < ActiveRecord::Migration[6.1]
  def change
    create_table :adoptions do |t|
      t.string :date
      t.integer :price
      t.integer :animal_id
      t.integer :visitor_id
    end
  end
end
