
class Page < ActiveRecord::Base
	belongs_to :publication
	validates :id, :uniqueness => true

	has_and_belongs_to_many :requests
end


