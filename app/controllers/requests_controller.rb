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
	# changes to the keyword and date elements to ensure they are recognized as valid api inputs
	if andtext.match(/\s/) 
		andtext = andtext.gsub!(/\s+/, '+')
	end
	if ortext.match(/\s/)
		ortext = ortext.gsub!(/\s+/, '+')
	end
	if phrasetext.match(/\s/)
		phrasetext = phrasetext.gsub!(/\s+/, '+')
	end
	if month1 < 10
		month1 = "0#{month1}"
	end
	if month2 < 10
		month2 = "0#{month2}"
	end
	if day1 < 10
		day1 = "0#{day1}"
	end
	if day2 < 10
		day2 = "0#{day2}"
	end
	url = base_url + "&date1=#{month1}%2F#{day1}%2F#{year1}&date2=#{month2}%2F#{day2}%2F#{year2}&andtext=#{at}&ortext=#{ot}&phrasetext=#{pt}&state=#{state}&lccn=#{lccn}&format=json" 
	url
end

private
def request_params
	params.require(:request).permit(:state, :lccn, :andtext, :ortext, :phrasetext, :year1, :month1, :day1, :year2, :month2, :day2)
end

end