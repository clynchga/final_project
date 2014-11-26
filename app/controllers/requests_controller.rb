class RequestsController < ApplicationController

def new
	@request = Request.new
end

def create
	@request = Request.new(request_params)
	#@request.url = "http://chroniclingamerica.loc.gov/search/pages/results/?dateFilterType=range&date1=01%2F01%2F1836&date2=12%2F31%2F1922&andtext=&ortext=&phrasetext=&state=&lccn=&format=json"
	@request.url = build_url(@request.year1, @request.month1, @request.day1, @request.year2, @request.month2, @request.day2, @request.andtext, @request.ortext, @request.phrasetext, @request.state, @request.lccn)
	
	respond_to do |format|	
		# if the request object does not already exist, save it and return the object
		if Request.find_by(url: @request.url).nil? 
			if @request.save
				#raw_response = HTTParty.get(@request.url)
				#@request.num_pages = JSON.parse(raw_response.body)["totalItems"].to_i
	   			format.html { redirect_to "/results/#{@request.id}", notice: 'Saved request to db' }
	   		else
	  	 		format.html { render :new }
			end
	   	# if the request url already exists, pull the request object
	   	else
	   		@request = Request.find_by(url: @request.url)
	   		format.html { redirect_to "/results/#{@request.id}", notice: 'Located request in db' }
		end
	end

end

def index
	@requests = Request.all
end 

def build_url(year1, month1, day1, year2, month2, day2, andtext, ortext, phrasetext, state, lccn)
	base_url = "http://chroniclingamerica.loc.gov/search/pages/results/?dateFilterType=range"
	# check the keyword and date elements to ensure they are recognized as valid api inputs
	# this is ugly and repetitive, fix it later
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
	# return only page 1 results if no keyword search is specified
	if andtext.nil? && ortext.nil? && phrasetext.nil? 
		url = base_url + "&date1=#{month1}%2F#{day1}%2F#{year1}&date2=#{month2}%2F#{day2}%2F#{year2}&andtext=#{andtext}&ortext=#{ortext}&phrasetext=#{phrasetext}&state=#{state}&lccn=#{lccn}&format=json&sequence=1" 
	else
		url = base_url + "&date1=#{month1}%2F#{day1}%2F#{year1}&date2=#{month2}%2F#{day2}%2F#{year2}&andtext=#{andtext}&ortext=#{ortext}&phrasetext=#{phrasetext}&state=#{state}&lccn=#{lccn}&format=json"
	end
	url
end

private
def request_params
	params.require(:request).permit(:state, :lccn, :andtext, :ortext, :phrasetext, :year1, :month1, :day1, :year2, :month2, :day2)
end

end