#Name a part of the human body (7 letters). The first four letters, in order, spell a familiar boy's name. The second through fifth letters (in order) spell another boy's name. What's the word?

#list of boy's names from https://www.cs.cmu.edu/afs/cs/project/ai-repository/ai/areas/nlp/corpora/names/male.txt

#it's hard to find a good "body part" corpus, so I should check name combinations to see if they produce a valid word

dictionary_file = File.read "/usr/share/dict/words"
dictionary_array = []

dictionary_file.lines.each do |line|
			dictionary_array << line.chomp.downcase
end

names_file = File.read "./commonMaleNames.txt"
names_array = []

names_file.lines.each do |line|
			names_array << line.chomp.downcase
end

=begin
target word looks like: body part |  0  1  2  3  4  5  6  |
								    |___________| name1
								       |___________| name 2
=end
combination_array = []
names_array.each do |name1|
	if name1.length == 4
		names_array.each do |name2|
			if name2.length == 4
				combo = ""
				name1_substring = name1[0..3]
				name2_substring = name2[3..3]
				combo = name1_substring + "" + name2_substring
				if name1[1..3] == name2[0..2]
					combination_array << combo
					puts "Name1: " + name1_substring.to_s + "|" + "Name2:" + name2_substring.to_s + "|" + "Combo:" + combo.to_s + name2.to_s
				end
			end
		end
	end
end

dictionary_array.each do |word|
	if word.length == 7
		combination_array.each do |name|
			if word != name
				if word.include?(name)
					puts word
				end
			end
		end
	end
end

#puts combination_array

#The answer is Earl, Arlo, Earlobe!