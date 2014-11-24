
class PublicationsController < ApplicationController

def self.find_id_by_lccn(lccn)
	@publication = Publication.where(lccn: lccn).first
	@publication.id
end



end