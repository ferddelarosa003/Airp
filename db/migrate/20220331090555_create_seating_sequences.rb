class CreateSeatingSequences < ActiveRecord::Migration[7.0]
  def change
    create_table :seating_sequences do |t|

      t.timestamps
    end
  end
end
