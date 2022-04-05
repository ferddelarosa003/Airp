class CreateAirplanes < ActiveRecord::Migration[7.0]
  def change
    create_table :airplanes do |t|

      t.timestamps
    end
  end
end
