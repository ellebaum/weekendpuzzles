#Name a major world city with a population in the millions. Take one letter in its name and move it two spots earlier in the alphabet. Reading backward, you now have the name of a major restaurant chain. What is it?

#Sydney => Wendy's

rest_file = File.read "./restaurants.txt" #top 250 restaurant chains in America
rest_hash = Hash.new
rest_file.lines.each do |line|
	word = line.gsub(/[^a-zA-Z]/,'').chomp.downcase
	word_value = 0
	word.chars.each do |char|
		word_value = word_value + char.ord
	end
	rest_hash.store(word, word_value)
end

city_file = File.read "./cities.txt"
city_hash = Hash.new
city_file.lines.each do |line|
	word = line.gsub(/[^a-zA-Z]/,'').chomp.downcase
	word_value = 0
	word.chars.each do |char|
		word_value = word_value + char.ord
	end
	city_hash.store(word, word_value)
end

rest_hash.each do |rest_k, rest_v|
	if city_hash.value?(rest_v.to_i + 2) #one letter two spots earlier in alphabet
		puts city_hash.key(rest_v.to_i + 2)
		puts rest_k
		puts "=============="
	end
end