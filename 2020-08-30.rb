#Name a famous person in history (5,4). The letters of the last name can be rearranged to name a popular game. And the letters in the first name can be rearranged to name an action in this game. Who is this famous person?

#answer: marco polo
require 'yaml'
require "engtagger"

tagger = EngTagger.new

dict_file = File.read "/usr/share/dict/words"
dict_four_hash = Hash.new{|k, v| k[v] = []}
dict_five_hash = Hash.new{|k, v| k[v] = []}
dict_file.lines.each do |word|
	word.gsub!(/\W+/, '').downcase!
	tagged = tagger.get_readable(word)
	if word.chomp.length == 4 
		word_value = 0
		word.chars.each do |char|
			word_value = word_value + char.ord
		end
		dict_four_hash[word_value].push(word)
	elsif word.chomp.length == 5 && (tagged.include?("VB") || tagged.include?("NN"))
		word_value = 0
		word.chars.each do |char|
			word_value = word_value + char.ord
		end
		dict_five_hash[word_value].push(word)
	end
end
dict_four_hash.each do |k, v|
	v.uniq!
end
dict_five_hash.each do |k, v|
	v.uniq!
end

last_name_file = File.read "./last-names.txt"
last_hash = Hash.new{|k, v| k[v] = []}
last_name_file.lines.each do |word|
	word.chomp!
	if word.length == 4
		word_value = 0
		word.chars.each do |char|
			word_value = word_value + char.ord
		end
		last_hash[word_value].push(word)
	end
end

first_name_file = File.read "./first-names.txt"
first_hash = Hash.new{|k, v| k[v] = []}
first_name_file.lines.each do |word|
	word.chomp!
	if word.length == 5
		word_value = 0
		word.chars.each do |char|
			word_value = word_value + char.ord
		end
		first_hash[word_value].push(word)
	end
end

first_solutions = Hash.new{|k, v| k[v] = []}
first_hash.each do |first_key, first_values|
	if dict_five_hash.key?(first_key)
		first_values.each do |first_name|
			dict_five_hash[first_key].each do |word|
				if first_name.chars.sort.join == word.chars.sort.join && first_name != word
					first_solutions[word].push(first_name)
				end
			end
		end
	end
end
first_solutions_sorted = first_solutions.sort.to_h
File.open("./first_solutions.yaml", "w") { |file| file.write(first_solutions_sorted.to_yaml)}

last_solutions = Hash.new{|k, v| k[v] = []}
last_hash.each do |last_key, last_values|
	if dict_four_hash.key?(last_key)
		last_values.each do |last_name|
			dict_four_hash[last_key].each do |word|
				if last_name.chars.sort.join == word.chars.sort.join && last_name != word
					last_solutions[word].push(last_name)
				end
			end
		end
	end
end
last_solutions_sorted = last_solutions.sort.to_h
File.open("./last_solutions.yaml", "w") { |file| file.write(last_solutions.to_yaml)}