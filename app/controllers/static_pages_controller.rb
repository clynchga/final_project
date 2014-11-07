

class StaticPagesController < ApplicationController

	def index
		@return = Page.100years	
	end

end