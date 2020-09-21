#Take the name of a famous actor - four letters in the first name, five letters in the last. Spoonerize (ph) it - that is, interchange the initial consonant sounds of the first and last names. And the result will be two new, familiar first names - one male, one female - that start with the same letter. But that letter is pronounced differently in the two names. Who's the actor?

#Answer: John Wayne (Juan, Jane)

###########################################################
#####Run once to build actor file and then comment out#####
###########################################################
=begin
actor_file = File.read "./data.tsv" #from imdb
actor_array = []
actor_file.lines.each do |line|
	actor_name = line.split("\t")[1]
	roles = line.split("\t")[4].split(",")
	if roles.include?('actor') || roles.include?('actress')
		if actor_name.split[0].length == 4 && actor_name.split[-1].length == 5
			actor_array << actor_name.chomp.downcase
		end
	end
end

actor_array.uniq!
puts actor_array.length

File.open("solutions.txt", "w+") do |f|
  actor_array.each { |element| f.puts(element) }
end
=end
#############################################################
#############################################################
#############################################################

name_file = File.read "./first-names.txt"
name_array = []
name_file.lines.each do |line|
	if line.length >= 4
		name_array << line.chomp.downcase
	end
end

actor_file = File.read "./solutions.txt"
actor_array = []
actor_file.lines.each do |line|
	first = line.split[0]
	last = line.split[-1]
	if !(/^[^aeiou\W]/i.match(first) == nil && /^[^aeiou\W]/i.match(last) == nil)
		actor_array << line.chomp
	end
end

cmu_dict_file = File.read "./cmudict.dict" #Carnegie Mellon Pronouncing Dictionary
cmu_dict_hash = Hash.new{|k, v| k[v] = []}
cmu_dict_file.lines.each do |line|
	word = line.split[0]
	ipa = line.split[1..-1]
	cmu_dict_hash[word].push(ipa)
end
cmu_phones_file = File.read "./cmudict.phones"
cmu_phones_hash = Hash.new
cmu_phones_file.lines.each do |line|
	cmu_phones_hash.store(line.split[0].to_s, line.split[1].to_s)
end

actor_array.each do |actor|
	first_name = actor.split[0]
	last_name = actor.split[-1]
	first_name_ipa = cmu_dict_hash[first_name].flatten
	last_name_ipa  = cmu_dict_hash[last_name].flatten
	name1_ipa = []
	name2_ipa = []
	first_name_first_vowel_index = 0
	last_name_first_vowel_index = 0

	if cmu_dict_hash.has_key?(first_name) && cmu_dict_hash.has_key?(last_name)
		first_name_ipa.each_with_index do |phone, i|
			phone_string = phone.to_s
			if cmu_phones_hash[phone_string.gsub!(/\W+/, '')] == "vowel"
				first_name_first_vowel_index = i
				break
			end
		end
		last_name_ipa.each_with_index do |phone, i|
			if cmu_phones_hash[phone.gsub!(/\W+/, '')] == "vowel"
				last_name_first_vowel_index = i
				break
			end
		end
	end
	name1_ipa.push(cmu_dict_hash[last_name][0..(last_name_first_vowel_index - 1)])
	name1_ipa.concat(cmu_dict_hash[first_name][last_name_first_vowel_index..-1])
	name2_ipa.push(cmu_dict_hash[first_name][0..(first_name_first_vowel_index - 1)])
	name2_ipa.concat(cmu_dict_hash[last_name][first_name_first_vowel_index..-1])
	name1_ipa.flatten!
	name2_ipa.flatten!

	if cmu_dict_hash.has_value?(name1_ipa) && cmu_dict_hash.has_value?(name2_ipa)
		name1 = cmu_dict_hash.key(name1_ipa)
		name2 = cmu_dict_hash.key(name2_ipa)
		if name1[0] == name2[0]
			if name_array.include?(name1) && name_array.include?(name2)
				puts actor
			end
		end
	end
end