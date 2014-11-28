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
	@requestid = request.id

end

def paginate_results
	orig_id = params[:id]
	page_num = params[:pagenum]

	orig_url = Request.find(orig_id).url 
	new_url = orig_url + "#{page_num}" 

	@pages = save_data_from_api(new_url)

	# if this request hasn't been made before, copy the fields of the original request and change the url
	# save this new request to the db so we remember it
	if Request.find_by(url: new_url).nil? 
		oldr = Request.find(orig_id)
		newr = oldr.dup
		newr.url = new_url
		newr.index1 = ((page_num.to_i - 1) * 20) + 1
		newr.index2 = ((page_num.to_i - 1) * 20) + @pages.length 
		newr.save 
	end

	request = Request.find_by(url: new_url)

	@total_pages = request.num_pages
	@pageindex1 = request.index1
	@pageindex2 = request.index2
	@previouspagenum = page_num.to_i - 1
	@nextpagenum = page_num.to_i + 1
	@thispagenum = page_num.to_i

	@requestid = orig_id

end


def save_data_from_api(request_url)

	response_pages = []

	request_id = Request.find_by(url: request_url)

	# check to see if a link record for request-pages already exists
	# if so, no need to execute another api call, use the cached pages data from the db

	if Link.find_by(request_id: request_id).nil?
		response = HTTParty.get(request_url)
		parsed_response = JSON.parse(response.body)
		pages_data = parsed_response["items"]

		pages_data.each do |pd|
			page = Page.new
			page.publication_id = Publication.find_id_by_lccn(pd["lccn"]) 
			page.date = pd["date"]
			page.seq = pd["sequence"]
			page.lccn = pd["lccn"]
			page.ocr_text = pd["ocr_eng"]

			slicelength = pd["url"].length - 5
			page.img_url = pd["url"][0,slicelength] + ".pdf"

			id_sections = pd["id"].split("/")
			page.datefield = id_sections[3]
			page.year = page.datefield[0,4].to_i
			page.month = page.datefield[5,2].to_i
			page.day = page.datefield[8,2].to_i

			id_section_ed = id_sections[4]
			ed_data = id_section_ed.split("-")
			page.ed = ed_data[1].to_i

			page.save

			new_link = Link.new
			new_link.request_id = request_id
			new_link.page_id = page.id
			new_link.save

			response_pages.append(page)
		end
	else 
		link_objs = Link.where(request_id: request_id)
		link_objs.each do |obj|
			page_id = obj.page_id
			page = Page.find(page_id)

			response_pages.append(page)	
		end
	end



	return response_pages

end


end