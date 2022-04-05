class AddFieldsToAirplanes < ActiveRecord::Migration[7.0]
  def change
    add_column :airplanes, :name, :string
  end
end
