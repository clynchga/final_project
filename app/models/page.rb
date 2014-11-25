
class Page < ActiveRecord::Base
	validates :id, :uniqueness => true

	has_and_belongs_to_many :requests
end


