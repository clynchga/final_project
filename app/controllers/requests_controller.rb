class RequestsController < ApplicationController

def new
	@request = Request.new
end

def create
	@request = Request.new(request_params)
	@request.url = Request.build_url(@request.year1, @request.month1, @request.day1, @request.year2, @request.month2, @request.day2, @request.andtext, @request.ortext, @request.phrasetext, @request.state, @request.lccn)
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

def self.build_url(year1, month1, day1, year2, month2, day2, andtext, ortext, phrasetext, state, lccn)
	base_url = "http://chroniclingamerica.loc.gov/search/pages/results/?dateFilterType=range"
	url = base_url + "&date1=#{month1}/#{day1}/#{year1}&date2=#{month2}/#{day2}/#{year2}&andtext=#{andtext}&ortext=#{ortext}&phrasetext=#{phrasetext}&state=#{state}&lccn=#{lccn}"
	url
end

private
def request_params
	params.require(:request).permit(:state, :lccn, :andtext, :ortext, :phrasetext, :year1, :month1, :day1, :year2, :month2, :day2)
end

end