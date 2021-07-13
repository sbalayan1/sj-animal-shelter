class ChangeShelterLocationIdToInteger < ActiveRecord::Migration[6.1]
  def change
    change_column :shelters, :location_id, :integer
  end
end
