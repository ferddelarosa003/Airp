# frozen_string_literal: true

class SeatingSequencesController < ApplicationController
  def index
    @seating_sequence = SeatingSequence.new
    @seating_sequences = SeatingSequence.all
    respond_to do |format|
      format.html
      format.json { render @seating_sequences, status: :ok }
    end
  end

  def show
    @seating_sequence = SeatingSequence.find(params[:id])
    # @sequence = eval(@seating_sequence.sequence)
    # @s_count = 0
    @row_max = eval(@seating_sequence.sequence).map(&:first).max
    @arrangements = AssignSeatService.call(@seating_sequence, params[:passenger_count])
  end

  def create
    @seating_sequence = SeatingSequence.new(seating_sequence_params)
    if @seating_sequence.save
      redirect_to @seating_sequence
    else
      render :index, errors: @seating_sequence.errors.full_messages
    end
  end

  def populate
    render json: [[1, 2], [3, 2], [3, 2]]
  end

  private

  def seating_sequence_params
    params.require(:seating_sequence).permit(:sequence, :airplanes_id)
  end
end
