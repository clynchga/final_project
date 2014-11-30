class SearchesController < ApplicationController

before_action :authenticate_user!

def index

	user_id = current_user.id
	@request_ids = Search.where(user_id: user_id).distinct.pluck(:request_id)
	# returns an array of ids, or an empty array

	@requests = Request.find(@request_ids)
	# returns an array of request objects, or an empty array
end

end 