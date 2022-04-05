class AddFieldsToSeatingSequences < ActiveRecord::Migration[7.0]
  def change
    add_column :seating_sequences, :sequence, :text
  end
end
