#Think of two common phrases in the form "____ and ____", in which the blanks are four-letter words. All four words have different first letters, but the last three letters are all the same. What are the phrases?

#Take dictionary, include only word.length == 4

dictionary_file = File.read "/usr/share/dict/words"
dictionary_array = []

dictionary_file.lines.each do |line|
	if line.chomp.length == 4
		dictionary_array << line.chomp.downcase
	end
end

#for each word, check all other words in dictionary and see if they are the same except for the first letter. Add all of these words to an array, then put that array into another array

words_array_array = []

dictionary_array.each do |word1|
	dictionary_array.each do |word2|
		words_array = []
		words_array << word1
		if word1[0] != word2[0] && word1[1,3] == word2[1,3]
			words_array << word2
		end
			words_array_array << words_array
		end
	end
end


puts words_array_array

#near and dear, wear and tear
