class RequestsController < ApplicationController

def new
	@request = Request.new
end

def create
	@request = Request.new(request_params)
	@request.url = build_url(@request.year1, @request.month1, @request.day1, @request.year2, @request.month2, @request.day2, @request.andtext, @request.ortext, @request.phrasetext, @request.state, @request.lccn)
	
	respond_to do |format|	
		# if the request object does not already exist, save it to the db
		if Request.find_by(url: @request.url).nil? 
			raw_response = HTTParty.get(@request.url)
			@request.num_pages = JSON.parse(raw_response.body)["totalItems"]
			@request.index2 = JSON.parse(raw_response.body)["endIndex"]
			@request.index1 = JSON.parse(raw_response.body)["startIndex"]

			@request.save
			
			#if @request.save
	   		format.html { redirect_to "/results/#{@request.id}" }
	   		#else
	  	 		#format.html { render :new }
			#end
	   	# if the request url already exists, pull the request object
	   	else
	   		@request = Request.find_by(url: @request.url)
	   		format.html { redirect_to "/results/#{@request.id}" }
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
	# return only front page results if no keyword search is specified
	if andtext == "" && ortext == "" && phrasetext == ""
		url = base_url + "&date1=#{month1}%2F#{day1}%2F#{year1}&date2=#{month2}%2F#{day2}%2F#{year2}&andtext=#{andtext}&ortext=#{ortext}&phrasetext=#{phrasetext}&state=#{state}&lccn=#{lccn}&format=json&sequence=1&page=" 
	else
		url = base_url + "&date1=#{month1}%2F#{day1}%2F#{year1}&date2=#{month2}%2F#{day2}%2F#{year2}&andtext=#{andtext}&ortext=#{ortext}&phrasetext=#{phrasetext}&state=#{state}&lccn=#{lccn}&format=json&page="
	end
	url
end

private
def request_params
	params.require(:request).permit(:state, :lccn, :andtext, :ortext, :phrasetext, :year1, :month1, :day1, :year2, :month2, :day2)
end

end