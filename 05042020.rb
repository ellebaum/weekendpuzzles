#Think of a well known US city (pop > 250k). Phonetically, the first syllable of the city name plus the first syllable of the city's state will sound like a well known brand name. What is it?

require 'json'
require 'text-hyphen'

hh = Text::Hyphen.new

file = File.read "./citiesAndStates.json"
citiesAndStates = JSON.parse(file)

city_over_200_array = [] #setting the population at 200k instead of 250k to be conservative
phonetic_city_array = []
state_array = []
phonetic_state_array = []
#city_count = 0

citiesAndStates.each do |i|
	city = citiesAndStates.shift
	if (city["population"].to_i >= 200000)
		city_over_200_array << city["city"].downcase.chomp
		state_array << city["state"].downcase.chomp
		#city_count = (city_count + 1)
	end
end
=begin
city_over_200_array.each do |city|
	word = city_over_200_array.shift
	phonetic_city_array << hh.visualize(word)
end

state_array.each do |state|
	word = state_array.shift
	phonetic_state_array << hh.visualize(word)
end

puts phonetic_state_array

word = "representation"
points = hh.hyphenate(word)
puts hh.visualize(word)
=end

state_array.each do |state|
	state = state_array.shift
	city = city_over_200_array.shift
	puts city + " " + state
end


#puts city_over_200_array
#puts state_array
#puts city_count.to_s
#the count is 113 which passes a sanity test

#I can't figure out how to automate it well but I think the answer is Aurora, CO -> Oracle