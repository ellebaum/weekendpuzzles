#Name a well-known restaurant chain. Rearrange its letters to name a large area in the United States. And this area has a two-word name. What is it? 

dictionary_file = File.read "/usr/share/dict/words"
dictionary_hash = {}
dictionary_file.lines.each do |line|
	dictionary_hash.store(line.chomp.downcase, line.chomp.downcase.sum)
end

restaurant_file = File.read "./restaurants.txt"
restaurant_hash = {}
restaurant_file.lines.each do |line|
	restaurant_hash.store(line.gsub(/[^a-zA-Z]/, '').chomp.downcase, line.gsub(/[^a-zA-Z]/, '').chomp.downcase.sum)
end

restaurant_hash.each do |rest, rest_value|
	puts rest
	dictionary_hash.each do |word1, word1_value|
		dictionary_hash.each do |word2, word2_value|
			if rest_value == word1_value + word2_value
				if rest.chars.sort.join == (word1 + word2).chars.sort.join
					puts "Restaurant: " + rest
					puts "words: " + word1 + "   " + word2
				end
			end
		end
	end
end

#the answer is Taco Bell -> Coal Belt
