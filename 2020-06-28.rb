#This week's challenge comes from listener Ed Pegg Jr., who runs the website MathPuzzle.com. Think of a five-letter animal. Remove the middle letter, and two opposites remain. What animal is it?

=begin
#find all two letter words
dictionary_file = File.read "/usr/share/dict/words"
two_array = []
dictionary_file.lines.each do |line|
	if line.chomp.length == 2
		two_array << line.chomp.downcase
	end
end

#find all five letter words
five_array = []
dictionary_file.lines.each do |line|
	if line.chomp.length == 5
		five_array << line.chomp.downcase
	end
end

#check if five letter words are composed of valid two letter words
candidate_array = []
five_array.each do |five|
	word1 = five[0..1]
	word2 = five[3..4]
	if two_array.include?(word1) && two_array.include?(word2)
		candidate_array << five
	end
end

puts candidate_array
=end

animal_file = File.read "./animals.txt"
animal_array = []
animal_file.lines.each do |line|
	if line.chomp.length == 5
		animal_array << line.chomp.downcase
	end
end

animal_array = animal_array.uniq.sort
puts animal_array

removed_array = []
animal_array.each do |animal|
	word1 = animal[0..1]
	word2 = animal[3..4]
	puts word1 + "   " + word2
	removed_array << (word1 + word2)
end

puts removed_array
puts removed_array.length

#nyala is the only thing that seems to make sense but NY/LA seems kind of a stretch
