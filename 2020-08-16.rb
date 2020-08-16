#Think of a major city in France whose name is an anagram of a major city in Italy. Each city has more than 100,000 people.

require 'json'

file = File.read "./countriesAndCities.json"
hash = JSON.parse(file)

french_array = []
italian_array = []

hash.each do |k, v|
	if k == "France"
		french_array = v
	end
	if k == "Italy"
		italian_array = v
	end
end

french_array.each do |fr|
	fr_temp = fr.downcase.chomp.chars.sort.join
	italian_array.each do |it|
		it_temp = it.downcase.chomp.chars.sort.join
		if fr_temp == it_temp && fr.chomp.downcase != it.chomp.downcase
			puts "France: " + fr
			puts "Italy: " + it
			puts "--------------"
		end
	end
end

#salerno, orleans
