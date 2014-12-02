class SavesController < ApplicationController

before_action :authenticate_user!

def index

	user_id = current_user.id
	@save_ids = Save.where(user_id: user_id).distinct.pluck(:page_id)
	# returns an array of ids, or an empty array

	@pages = Page.find(@save_ids)
	# returns an array of page objects, or an empty array
	

	# for sorting options
	sort = params[:sort]

	if sort == "pub" # sort by publication title
		@pages.sort! {|x,y| Publication.find_by(lccn: x.lccn).sort_title <=> Publication.find_by(lccn: y.lccn).sort_title}
	elsif sort == "dateasc" # sort by publication date (asc)
		@pages.sort! {|x,y| x.date <=> y.date}
	elsif sort == "datedesc" # sort by publication date (desc)
		@pages.sort! {|x,y| y.date <=> x.date}
	else # default: sort by save creation date (desc)
		@pages.sort! {|x,y| y.id <=> x.id}
	end

end

def create
	user_id = params[:user_id]
	page_id = params[:page_id]
	Save.create(user_id: user_id, page_id: page_id)
	@page_id = page_id
end

def new
end

def edit
end

def show
end

def destroy
	@user_id = Save.find(params[:id]).user_id
	@page_id = Save.find(params[:id]).page_id
	@saves = Save.where("user_id = ? AND page_id = ?", @user_id, @page_id)
	@save_ids = []
	@saves.each do |s|
		@save_ids.append(s.id)
	end

	Save.delete(@save_ids)

	redirect_to :action => 'index'
end


end 