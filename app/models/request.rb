class Request < ActiveRecord::Base
	validates :date1, :date2, :datefiltertype, presence: true
	# add validation for the format of date1 and date2 - should be 'yyyy' or 'mm/dd/yyyy'
	# add validation for the values of date1 and date2 - should be 1836 - 1922

end
