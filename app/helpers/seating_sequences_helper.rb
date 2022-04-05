module SeatingSequencesHelper
    def col_class(column,total_columns,s_count)
        seat = determine_seat(column,total_columns,s_count)
        SeatingSequence::SEAT_TYPES[seat]
    end

    def assign_seat(seating_sequence,passenger_count)
         #[[1, 2], [1, 3], [2, 2]], 9
       #[[3,2],[2,2],[1,2],[1,3]] , 11
       result = []
       
       sequence = eval(seating_sequence.sequence)
       window_seat_count = get_window_seats(sequence)
       middle_seat_count  = get_middle_seats(sequence)
       aisle_seat_count = get_total_aisle(sequence)
       sequence.map do|row_count,col_count|
            p "r_c: #{row_count}"
            0.upto(row_count-1).map do |row|
                 0.upto(col_count-1).map do |col|
                  {type: col_class(col,col_count-1,row_count-1),value: 0}
                end 
            end
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
        s_count == 0 && column == 0 ||  (s_count+1) == (@sequence.count ) &&  column == total_columns          
    end

    def aisle_seat?(column,total_columns)
        column == 0 || column == (total_columns )
    end

 
    #

end
