#Name the make and model of a popular car. Change the first and last letters of the make to name an animal. Change the first and fourth letters of the model to name another animal. What car is it?

#list of makes from https://gist.github.com/pcgeek86/78f4cad29dd16961ceeeee654127a0db#file-car-manufacturers-txt


car_file = File.read "./carMakes.txt"
car_array = []

car_file.lines.each do |line|
		car_array << line.chomp.downcase
end


dictionary_file = File.read "/usr/share/dict/words"
dictionary_array = []

dictionary_file.lines.each do |line|
	dictionary_array << line.chomp.downcase
end


car_array.each do |car|
	dictionary_array.each do |word|
		if car[1..-2] == word[1..-2] && car.length == word.length
			puts "Make: " + car + "|" + "Animal?: " + word 
		end
	end
end

=begin
Make candidates:

Make: bmw|Animal?: emu
Make: ford|Animal?: worm
Make: gmc|Animal?: emu
Make: jeep|Animal?: bees
Make: jeep|Animal?: deer
Make: kia|Animal?: pig
Make: toyota|Animal?: coyote

=end

#car models from https://github.com/FormidableLabs/radon-typeahead/blob/master/demo/car-models.json


require 'json'

file = File.read "./car_models.json"
car_models = JSON.parse(file)

puts "==========================================================================="


car_models.each do |make|
	if make["brand"] == "Ford" || make["brand"] == "Jeep" || make["brand"] == "Toyota" || make["brand"] == "BMW" || make["brand"] == "GMC" || make["brand"] == "Kia"
		make["models"].each do |model|
			if model.chomp.length == 4
				dictionary_array.each do |word|
					if model[1..2] == word[1..2] && word.chomp.length == model.chomp.length
						puts "model: " + model + "  animal?: " + word
					end
				end
			end
			if model.chomp.length >= 5
				dictionary_array.each do |word|
					if (model[1..2] == word[1..2] && model[4..-1] == word[4..-1]) && (word.chomp.length == model.chomp.length)
						puts "model: " + model + "  animal?: " + word
					end
				end
			end
		end
	end
end

=begin
Model Candidates:

model: Flex  animal?: flea
model: Rio5  animal?: lion
model: Corolla  animal?: gorilla

	
=end

#The answer is Toyota Corolla -> Coyote Gorilla