# frozen_string_literal: true

class Airplane < ApplicationRecord
  has_many :seating_sequences
end
