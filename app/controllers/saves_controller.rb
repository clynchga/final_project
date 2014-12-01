class SavesController < ApplicationController

before_action :authenticate_user!

def index

	user_id = current_user.id
	@save_ids = Save.where(user_id: user_id).distinct.pluck(:page_id)
	# returns an array of ids, or an empty array

	@pages = Page.find(@save_ids)
	# returns an array of page objects, or an empty array
end

def create
	user_id = params[:user_id]
	page_id = params[:page_id]
	Save.create(user_id: user_id, page_id: page_id)
	@page_id = page_id
end


end 