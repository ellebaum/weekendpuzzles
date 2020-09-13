#Name a famous person with the initials M. C. The first initial and last name anagram to the person's field of renown. What is it?

#cinema => Michael Caine

require 'yaml'

dict_file = File.read "/usr/share/dict/words"
dict_array = []
dict_file.lines.each do |line|
	word = line.chomp.downcase
		if word.include?('m') && word.include?('c')
			dict_array << word
		end
end
puts dict_array.length

last_name_file = File.read "./last-names.txt"
last_name_array = []
last_name_file.lines.each do |line|
	last_name = line.chomp.downcase
	if last_name != nil
		if last_name.start_with?('c')
			last_name_array << last_name
		end
	end
end
puts last_name_array.length

solutions_hash = Hash.new{|k, v| k[v] = []}
dict_array.each do |word|
	word_sorted = word.chars.sort.join
	last_name_array.each do |last_name|
		name_sorted = last_name.dup
		name_sorted << 'm'
		name_sorted = name_sorted.chars.sort.join
		if name_sorted == word_sorted
			solutions_hash[word].push(last_name)
		end
	end
end

solutions_sorted = solutions_hash.sort.to_h
File.open("./solutions.yaml", "w") { |file| file.write(solutions_sorted.to_yaml)}