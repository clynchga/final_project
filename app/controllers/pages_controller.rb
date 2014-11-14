require 'httparty'
require 'json'

class PagesController < ApplicationController

include HTTParty

def textsearch
	sample_text = 'liquor'
	date1 = 1914
	date2 = 1914
	response = HTTParty.get("http://chroniclingamerica.loc.gov/search/pages/results/?dateFilterType=yearRange&date1=1914&date2=1914&andtext=liquor&format=json")
	@pages = JSON.parse(response.body)
end

def new
end


def self.save_data_from_api(request_url)
	response = HTTParty.get(request_url)
	parsed_response = JSON.parse(response.body)
	pages_data = parsed_response["items"]

	pages_data.each do |pd|
		page = Page.new
		page.publication_id = Publication.find_id_by_lccn(pd["lccn"]) 
		page.date = pd["date"]
		page.seq = pd["sequence"]
		if pd["edition"].nil? 
			page.ed = 1
		else 
			page.ed = pd["edition"]
		end
		slicelength = pd["url"].lenth - 5
		page.img_url = pd["url"][0,slicelength] + ".pdf"
		page.save 
		page
	end
end


end