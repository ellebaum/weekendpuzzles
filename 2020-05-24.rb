#Name a 7 letter well-known European city. Remove the third letter to get a two-word phrase describing what you must do to win a race. Remove the fourth letter to two-word describing what you CAN'T do to win a race.

#city list from https://github.com/datasets/world-cities/blob/master/data/world-cities.csv

cities_file = File.read ('./world-cities.csv')
city_array = []
cities_file.lines.each do |line|
	line.chomp.downcase
	city = line.split(",")[0]
	if city.length == 7
		city_array << city.downcase
	end
end

dictionary_file = File.read "/usr/share/dict/words"
dictionary_array = []
dictionary_file.lines.each do |line|
	dictionary_array << line.chomp.downcase
end

class String
  def rem! n
    slice! n
    self
  end
  def rem n
    dup.rem! n
  end
end


#trim possible words that don't make sense
dictionary_array.delete("may")
dictionary_array.delete("ana")
dictionary_array.delete("ye")
dictionary_array.delete("ariel")
dictionary_array.delete("li")
dictionary_array.delete("wick")
dictionary_array.delete("erick")
dictionary_array.delete("hale")
dictionary_array.delete("io")
dictionary_array.delete("may")
dictionary_array.delete("vie")
dictionary_array.delete("ira")
dictionary_array.delete("aria")
dictionary_array.delete("va")
dictionary_array.delete("nero")
dictionary_array.delete("satan")
dictionary_array.delete("riel")
dictionary_array.delete("ores")
dictionary_array.delete("ora")
dictionary_array.delete("doric")
dictionary_array.delete("ra")
dictionary_array.delete("h")

city_array.each do |city|
	word1 = city.rem(2)
	word2 = city.rem(3)

	word1check = false
	6.times do |count|
		candidate1 = word1[0..count]
		candidate2 = word1[count+1..-1]
		if dictionary_array.include?(candidate1) && dictionary_array.include?(candidate2)
			word1check = true
		end
	end

	word2check = false
	6.times do |count|
		candidate1 = word2[0..count]
		candidate2 = word2[count+1..-1]
		if dictionary_array.include?(candidate1) && dictionary_array.include?(candidate2)
			word2check = true
		end
	end


	if word1check && word2check
		puts "City: " + city
	end
end

#the answer is Belfast