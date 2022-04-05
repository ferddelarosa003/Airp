class AirplanesController < ApplicationController

    def index
      @airplanes = Airplane.all
      respond_to do |format|
        format.html 
        format.json { render @airplanes, status: :ok }
      end 
    end

    def new
        @airplane = Airplane.new
    end

   
end
