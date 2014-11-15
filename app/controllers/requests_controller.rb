class RequestsController < ApplicationController

def new
	@request = Request.new
end

def create
	@request = Request.new(request_params)

	respond_to do |format|
		if @request.save
	   		format.html { redirect_to requests_path, notice: 'Saved request to db' }
	   		#format.json { render :show, status: :created, location: @product }
		else
	  	 	format.html { render :new }
	   		#format.json { render json: @product.errors, status: :unprocessable_entity }
		end
	end
end

def index
	@requests = Request.all
end 

private
def request_params
	params.require(:request).permit(:state, :lccn, :andtext, :ortext, :phrasetext, :year1, :month1, :day1, :year2, :month2, :day2)
end

end