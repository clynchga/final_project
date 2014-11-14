
class Page < ActiveRecord::Base
	belongs_to :publication
	validates :id, :uniqueness => true
end


