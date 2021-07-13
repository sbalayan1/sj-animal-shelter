class AddPasswordColumnToVisitors < ActiveRecord::Migration[6.1]
  def change
    add_column :visitors, :password, :string
  end
end
