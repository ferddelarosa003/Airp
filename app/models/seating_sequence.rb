# frozen_string_literal: true

class SeatingSequence < ApplicationRecord
  belongs_to :airplane, optional: true
  # serialize :sequence, Array
  SEAT_TYPES = {
    aisle_seat: 'blue',
    window_seat: 'green',
    middle_seat: 'red'
  }.freeze
end
