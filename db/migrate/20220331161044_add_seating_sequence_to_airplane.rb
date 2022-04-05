class AddSeatingSequenceToAirplane < ActiveRecord::Migration[7.0]
  def change
    add_reference :seating_sequences, :airplanes, index: true
    
  end
end
