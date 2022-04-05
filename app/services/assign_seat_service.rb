class AssignSeatService < ApplicationService
    attr_accessor :seating_sequence, :passenger_count

    def initialize(seating_sequence,passenger_count)
        @seating_sequence = seating_sequence
        @passenger_count = passenger_count
    end

    def call
        #[[1, 2], [1, 3], [2, 2]], 9
      #[[3,2],[2,2],[1,2],[1,3]] , 11
      result = []
      @passenger_count = 12
      @seat_counter = 0
      @sequence = eval(@seating_sequence.sequence)
      @sequence_count = @sequence.count
      @window_seat_count = get_window_seats(@sequence)
      @middle_seat_count  = get_middle_seats(@sequence)
      @aisle_seat_count = get_total_aisle(@sequence)
      @sequence.map do|row_col|
           @current_sequence = @sequence.index(row_col)
           row_count = row_col[0]
           col_count = row_col[1]
           rows(row_col)
        end
    end
    
    def rows(row_col)
        0.upto(row_col[0]-1).map do |current_row|
            @current_row = current_row
            cols(row_col[1] - 1)
        end
   end


   def cols(current_column)
      0.upto(current_column).map do |col|
        data =  seat_data(col,current_column,@current_sequence)
        {color: data[:color],value: @current_row}
      end 
   end

   def assign_seat(seat_data)
      return 0 if passenger_count == 0 
      unless @passenger_count ==0
        value = seat_counter(seat_data[:type])
      end 
   end

   def seat_counter(seat_type)
        if seat_type == :aisle_seat && @aisle_seat_count > 0
            @seat_counter += 1
            @passenger_count -= 1
            @aisle_seat_count -= 1
            return @seat_counter 
        # elsif seat_type == :window_seat && @window_seat_count > 0
        #     @window_seat_count -=1
        #     return 2
        else
            return "0"
        end 
   end 

   def get_total_aisle(array)
       aisle_count =[]
       window_seats = [array.first,array.last]
       middle_seats = array - window_seats
       aisle_count << get_window_seats(array)
       aisle_count << count_aisle(middle_seats)
       p aisle_count
       aisle_count.sum 
   end

   def get_window_seats(array)
       [array.first,array.last].map(&:first).sum 
   end

   def get_middle_seats(array)
       total_seats = array.map{ |arr|
           arr.inject(:*)
       }.sum
       mid_seats = total_seats - get_total_aisle(array) - get_window_seats(array)
   end 
   

   def count_aisle(array)
       aisle_count = []
       array.map{ |arr|
           if arr[1] > 2
               aisle_count << (2 * arr[0])
           else
               aisle_count << (arr.inject(:*))
           end 
       }
       aisle_count.sum
   end



   def determine_seat(column,total_columns,s_count)
       return :window_seat if window_seat?(column,total_columns,s_count)
       return :aisle_seat if aisle_seat?(column,total_columns)
       :middle_seat
   end 

   def window_seat?(column,total_columns,s_count)
       s_count == 0 && column == 0 ||  (s_count + 1) == (@sequence.count ) &&  column == total_columns          
   end

   def aisle_seat?(column,total_columns)
       column == 0 || column == (total_columns )
   end

    def seat_data(column,total_columns,s_count)
        seat = determine_seat(column,total_columns,s_count)
        {color:SeatingSequence::SEAT_TYPES[seat] ,type: seat}
    end



end
