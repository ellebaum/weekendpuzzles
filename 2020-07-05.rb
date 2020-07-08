#Think of an eight-letter word for something we all crave now. It consists of three consecutive men's nicknames. What are they?

#Answer: normalcy

dictionary_file = File.read "/usr/share/dict/words"
dictionary_hash = {}
dictionary_file.lines.each do |line|
	if line.gsub(/[^a-zA-Z]/, '').chomp.downcase.length == 8
		dictionary_hash.store(line.gsub(/[^a-zA-Z]/, '').chomp.downcase, line.gsub(/[^a-zA-Z]/, '').chomp.downcase.sum)
	end
end
dictionary_hash.uniq.sort!

name_file = File.read "./commonMaleNames.txt"
name_hash = {}
name_file.lines.each do |line|
	#assuming all of the names are > 1 letter long, 4 is the max length
	if line.gsub(/[^a-zA-Z]/, '').chomp.downcase.length <= 4 && line.gsub(/[^a-zA-Z]/, '').chomp.downcase.length >= 2
		name_hash.store(line.gsub(/[^a-zA-Z]/, '').chomp.downcase, line.gsub(/[^a-zA-Z]/, '').chomp.downcase.sum)
	end
end
name_hash.uniq.sort!

#puts dictionary_hash.length
# -> 13457
#words that don't start with one of the names can be removed from the dictionary hash
dictionary_hash.each do |word_key, word_value|
	starts_with = false
	name_hash.each do |name_key, name_value|
		if word_key.start_with?(name_key)
			starts_with = true
		end
	end
	if !starts_with
		dictionary_hash.delete(word_key)
	end
end
#puts dictionary_hash.length
# -> 1848

=begin
The only possible name length combiations are:
4 2 2
2 2 4
2 4 2

3 3 2
3 2 3
2 3 3,
=end
#this could probably be optimized by comparing hash values instead but it runs fast enough as-is
name_hash.each do |name_key, name_value|
	temp_name_hash = name_hash.dup
	if name_key.length == 4
		temp_name_hash.each do |name2_key, name2_value|
			if name2_key.length != 2
				temp_name_hash.delete(name2_key)
			end
		end
		temp_name_hash.each do |name2_key, name2_value|
			dictionary_hash.each do |word_key, word_value|
				if word_key.start_with?(name_key + name2_key)
					temp_name_hash.each do |name3_key, name3_value|
						if word_key == (name_key + name2_key + name3_key)
							puts word_key
						end
					end
				end
			end
		end
	elsif name_key.length == 3
		temp_name_hash.each do |name2_key, name2_value|
			if name_key.length == 4
				temp_name_hash.delete(name2_key)
			end
		end
		temp_name_hash.each do |name2_key, name2_value|
			dictionary_hash.each do |word_key, word_value|
				if word_key.start_with?(name_key + name2_key)
					temp_name_hash.each do |name3_key, name3_value|
						if word_key == (name_key + name2_key + name3_key)
							puts word_key
						end
					end
				end
			end
		end
	else
		temp_name_hash.each do |name2_key, name2_value|
			dictionary_hash.each do |word_key, word_value|
				if word_key.start_with?(name_key + name2_key)
					temp_name_hash.each do |name3_key, name3_value|
						if word_key == (name_key + name2_key + name3_key)
							puts word_key
						end
					end
				end
			end
		end
	end
end
=begin
-> altamira
bartered
chemical
curtsied
cylinder
dickered
gibbered
hankered
jonathan
londoner
lonelier
mattered
normalcy
paterson
roberson
salaried
seesawed
tempered
timelier
tuckered
urinated
valerian
waterway

'salaried' sort of works, but the best answer is 'normalcy'
=end