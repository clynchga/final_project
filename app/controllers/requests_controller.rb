class RequestsController < ApplicationController

def new
	@request = Request.new
end

def create
	@request = Request.new(request_params)

	respond_to do |format|
	if @request.save
   		#format.html { redirect_to store_products_path, notice: 'Product was successfully created.' }
   		#format.json { render :show, status: :created, location: @product }
	else
  	 	#format.html { render :new }
   		#format.json { render json: @product.errors, status: :unprocessable_entity }
	end
end
end

def index
	# show recent searches for a user
end 

private
def request_params
	params.require(:request).permit(:state, :lccn, :andtext, :ortext, :phrasetext, :date1, :date2, :datefiltertype)
end

end