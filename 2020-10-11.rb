#Name certain fruits - in the plural. Change the second letter to an L, and read the result backward. You'll name two things to drink. What are they?

#avocados soda cola


dictionary_file = File.read "/usr/share/dict/words"
dictionary_array = []
dictionary_file.lines.each do |word|
	word.gsub!(/[^a-zA-Z]/, '')
	if word.chomp.length >= 3
		dictionary_array << word.chomp.downcase
	end
end

dictionary_array.each do |word1|
	original = word1
	word1[1] = "l"
	reversed = word1.reverse
	dictionary_array.each do |word2|
		if reversed.start_with?(word2)
			dictionary_array.each do |word3|
				if reversed.sub(word2, "") == word3
					puts original
					puts word2 + " " + word3
					puts "==============="
				end
			end
		end
	end
end