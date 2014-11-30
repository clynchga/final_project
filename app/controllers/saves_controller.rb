class SavesController < ApplicationController

before_action :authenticate_user!

def index
end

def create
	user_id = params[:user_id]
	page_id = params[:page_id]
	Save.create(user_id: user_id, page_id: page_id)
end


end 