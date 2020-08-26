#Think of a place on earth with a four-word name. Take the third word. Advance three of its letters to the next letter of the alphabet (so A would become B, B would be come C, etc.). You'll get the fourth word in the name. What place is this?

#word3.length >= 4
#word4.length == word3.length (or word4.length == 3??)

#1. take sum of ords for each char in string
#2. build hash with ord sum as key and array of strings that = ord sum as value
#3. compare array with key=n to array of key=n+3
	#4. if words are same length and same_letter_count + difference_by_one_count == word.length, add word1 as a key and word2 in an array of values in new hash
#5. export to YAML and read

#=>
#good:
#-hope
#cape of good hope!

require 'yaml'

dict_file = File.read "/usr/share/dict/words"
dict_array = []
dict_file.lines.each do |line|
	line.gsub!(/\W+/, '')
	if line.chomp.length >= 4 #this is just an assumption
		dict_array << line.chomp.downcase
	end
end
dict_array.uniq!

#hash with values as keys and array of words as value
words_and_values_hash = Hash.new{|k, v| k[v] = []}
#steps 1 and 2
dict_array.each do |word|
	word_value = 0
	word.chars.each do |char|
		word_value = word_value + char.ord
	end
	words_and_values_hash[word_value].push(word)
end

solutions_hash = Hash.new{|k, v| k[v] = []}
#step 3
words_and_values_hash.each do |word1_sum, words1_array|
	if words_and_values_hash.key?(word1_sum + 3)
		words2_array = words_and_values_hash[word1_sum + 3]
		words1_array.each do |word1|
			words2_array.each do |word2|
				same_count = 0
				diff_by_one_count = 0
				if word1.length == word2.length
					word1.chars.each_with_index do |char, index|
						if word2[index].ord - char.ord == 1
							diff_by_one_count = diff_by_one_count + 1
						elsif word2[index].ord == char.ord
							same_count = same_count + 1
						end
					end
					if same_count + diff_by_one_count == word1.length
						solutions_hash[word1].push(word2)
					end
				end
			end
		end
	end
end

File.open("./solutions.yaml", "w") { |file| file.write(solutions_hash.to_yaml)}