require 'httparty'
require 'json'

class PagesController < ApplicationController

include HTTParty

def basic
	#today = '11/6/1914'
	response = HTTParty.get("http://chroniclingamerica.loc.gov/search/pages/results/?dateFilterType=range&date1=11/4/1914&date2=11/4/1914&format=json")
	@pages = JSON.parse(response.body)
	@headers = response.headers
	
end

def textsearch
	sample_text = 'liquor'
	response = HTTParty.get("http://chroniclingamerica.loc.gov/search/pages/results/?dateFilterType=yearRange&date1=1914&date2=1914&andtext=liquor&format=json")
	@pages = JSON.parse(response.body)
end



end