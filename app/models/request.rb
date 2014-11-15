class Request < ActiveRecord::Base
	#validates :year1, :year2, presence: true
	#validates :year1, :year2, :month1, :month2, :day1, :day2, numericality: { only_integer: true }
	#validates :year1, :year2, numericality: { greater_than_or_equal_to: 1836, less_than_or_equal_to: 1922 }
	#validates :month1, :month2, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
	#validates :day1, :day2, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 31 }
end
