# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'open-uri'
publications = open("http://chroniclingamerica.loc.gov/newspapers.txt")
lines = publications.readlines
lines.shift
lines.delete("\n")
lines.each do |l|
	pub_data = l.split(" | ")
	state = pub_data[1]
	title = pub_data[2].split(") ")[0] + ")"
	city = pub_data[2].match(/\((.+)\)/)[0]
	lccn = pub_data[3]
	Publication.create(title: title, state: state, lccn: lccn, city: city)
end

