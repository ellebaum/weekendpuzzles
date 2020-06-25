#Think of a 5-letter word. Change the first letter to the next letter of the alphabet, and you'll get a new word that doesn't share any sounds with the first word. Change that word's first letter to the next letter of the alphabet and you'll get a third word that doesn't share a sound with either of the first two words. What are the words?

dictionary_file = File.read "/usr/share/dict/words"
dictionary_array = []
dictionary_file.lines.each do |line|
	if line.chomp.downcase.length == 5 && line.chomp.match(/\A[[:alpha:]]+\z/)
		dictionary_array << line.chomp.downcase
	end
end
dictionary_array.sort 
#to reduce possible solution space, only include arrays of words that share the same last four letters.
word_combo_list_list = []
dictionary_array.each do |word1|
	word_combo_list = [word1]
	dictionary_array.each do |word2|
		if word1[1..-1] == word2[1..-1]
			word_combo_list << word2
			word_combo_list_list << word_combo_list
			dictionary_array.delete word1
			dictionary_array.delete word2
		end
	end
end
#puts word_combo_list_list.length
#->1856
#...and make sure those arrays have at least 3 words
word_combo_list_list.each do |list|
	if list.length < 3
		word_combo_list_list.delete list
	end
end
#puts word_combo_list_list.length
#->1595
=begin
word_combo_list_list.each do |list|
	puts list
	puts "============"
end
=end
#list looks right(ish)

#answer is bough, cough, dough

#!!!!!!!!!!!!!!!!!!!!!!!to-do!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
=begin
#check if there are triplets that meet the 'next letter in alphabet' requirement
alphabet = ('a'..'z').to_a 
word_combo_list_list.each do |list|
	list.each do |word1|
		list.each do |word2|
			list.each do |word3|
				if !((alphabet.find_index(word1[0]) + 1 - alphabet.find_index(word2[0]) + 1 == 1) || (alphabet.find_index(word1[0]) + 1 - alphabet.find_index(word2[0]) + 1 == -1)) && (alphabet.find_index(word2[0]) + 1 - alphabet.find_index(word3[0]) + 1 == 1) || ((alphabet.find_index(word2[0]) + 1 - alphabet.find_index(word3[0]) + 1 == -1))

					word_combo_list_list.delete list
				end
			end
		end
	end
end
=end
puts word_combo_list_list