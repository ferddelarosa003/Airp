# frozen_string_literal: true

class AssignSeatService < ApplicationService
  attr_accessor :seating_sequence, :passenger_count

  def initialize(seating_sequence, passenger_count)
    @seating_sequence = seating_sequence
    @passenger_count = passenger_count
  end

  def call
    @passenger_count = 12
    @seat_counter = 0
    @sequence = eval(@seating_sequence.sequence)
    @sequence_count = @sequence.count
    @sequence.map do |row_col|
      @current_sequence = @sequence.index(row_col)
      row_count = row_col[0]
      col_count = row_col[1]
      rows(row_col)
    end
  end

  def rows(row_col)
    0.upto(row_col[0] - 1).map do |current_row|
      @current_row = current_row
      cols(row_col[1] - 1)
    end
  end

  def cols(current_column)
    0.upto(current_column).map do |col|
      data = seat_data(col, current_column, @current_sequence)
      { color: data[:color], value: @current_row }
    end
  end

  def determine_seat(column, total_columns, s_count)
    return :window_seat if window_seat?(column, total_columns, s_count)
    return :aisle_seat if aisle_seat?(column, total_columns)

    :middle_seat
  end

  def window_seat?(column, total_columns, s_count)
    s_count.zero? && column.zero? || (s_count + 1) == (@sequence.count) && column == total_columns
  end

  def aisle_seat?(column, total_columns)
    [0, total_columns].include?(column)
  end

  def seat_data(column, total_columns, s_count)
    seat = determine_seat(column, total_columns, s_count)
    { color: SeatingSequence::SEAT_TYPES[seat], type: seat }
  end
end
