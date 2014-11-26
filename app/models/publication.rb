class Publication < ActiveRecord::Base
	has_many :pages
	validates :lccn, :uniqueness => true

	def self.find_id_by_lccn(lccn)
		@publication = Publication.where(lccn: lccn).first
		@publication.id
	end

end
