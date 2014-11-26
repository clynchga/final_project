# require 'httparty'
# require 'json'

class PagesController < ApplicationController

# include HTTParty

def textsearch
	sample_text = 'liquor'
	date1 = 1914
	date2 = 1914
	response = HTTParty.get("http://chroniclingamerica.loc.gov/search/pages/results/?dateFilterType=yearRange&date1=1914&date2=1914&andtext=liquor&format=json")
	@pages = JSON.parse(response.body)
end


def results
	request_id = params[:id]

	request = Request.find(request_id)
	request_url = request.url
	@pages = save_data_from_api(request_url)
	
	
	# if RequestPage.find_by(request_id: request_id)
	# 	# if the request id already exists in the association table, pull the page ids

	# else 
	# 	# make a new request from the api using the request_url
	# 	@pages = Page.save_data_from_api(request_url)
	# end
end


def save_data_from_api(request_url)
	response = HTTParty.get(request_url)
	parsed_response = JSON.parse(response.body)
	pages_data = parsed_response["items"]

	response_pages = []

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
		slicelength = pd["url"].length - 5
		page.img_url = pd["url"][0,slicelength] + ".pdf"

		# for each created/found page make a record in the association table with the request id and page id
		if Page.find_by img_url: page.img_url
			#RequestPage.create(request_id: Request.find_by(url: request_url).id, page_id: Page.find_by(img_url: page.img_url).id)
			response_pages.append(Page.find_by(img_url: page.img_url))
		else 
			page.save 
			#RequestPage.create(request_id: Request.find_by(url: request_url).id, page_id: page.id)
			response_pages.append(page)
		end
	end

	return response_pages

end


end