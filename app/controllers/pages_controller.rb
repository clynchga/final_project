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
	@total_pages = request.num_pages
	@pageindex1 = request.index1
	@pageindex2 = request.index2

end

def paginate_results
	orig_id = params[:id]
	page_id = params[:pagenum]

	orig_url = Request.find(orig_id).url 
	new_url = orig_url + "#{page_id}" 

	# if this request hasn't been made before, copy the fields of the original request and change the url
	# save this new request to the db so we remember it
	if Request.find_by(url: new_url).nil? 
		oldr = Request.find(orig_id)
		newr = oldr.clone
		newr.url = new_url
	end

	@pages = save_data_from_api(new_url)
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
		page.lccn = pd["lccn"]
		slicelength = pd["url"].length - 5
		page.img_url = pd["url"][0,slicelength] + ".pdf"
		id_sections = pd["id"].split("/")
		page.datefield = id_sections[3]
		id_section_ed = id_sections[4]
		ed_data = id_section_ed.split("-")
		page.ed = ed_data[1].to_i

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