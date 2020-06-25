#Think of a famous person whose name consists of three names. The first and last letters of the first name plus the first and last letters of the second name plus the first and last letters of the third name, in order, name a city and lake in Europe. Who is it?

require 'json'

def self.remove_accents(str)
    accents = {
      ['á','à','â','ä','ã'] => 'a',
      ['Ã','Ä','Â','À'] => 'A',
      ['é','è','ê','ë'] => 'e',
      ['Ë','É','È','Ê'] => 'E',
      ['í','ì','î','ï'] => 'i',
      ['Î','Ì'] => 'I',
      ['ó','ò','ô','ö','õ'] => 'o',
      ['Õ','Ö','Ô','Ò','Ó'] => 'O',
      ['ú','ù','û','ü'] => 'u',
      ['Ú','Û','Ù','Ü'] => 'U',
      ['ç'] => 'c', ['Ç'] => 'C',
      ['ñ'] => 'n', ['Ñ'] => 'N'
    }
    accents.each do |ac,rep|
      ac.each do |s|
        str = str.gsub(s, rep)
      end
    end
    str = str.gsub(/[^a-zA-Z0-9\. ]/,"")
    str = str.gsub(/[ ]+/," ")
end

euro_countries_file = File.read "./europeanCountries.txt"
euro_countries_array = []
euro_countries_file.lines.each do |line|
	euro_countries_array << remove_accents(line.chomp.downcase)
end
file = File.read "./countriesAndCities.json"
countries_and_cities_file = JSON.parse(file)
euro_city_array = []
countries_and_cities_file.each do |key,value|
	country = countries_and_cities_file.shift
	if euro_countries_array.include?(key.chomp.downcase)
		value.each do |city|
			if city.chomp.length <= 6 && city.chomp.length > 0
				euro_city_array << city.chomp.downcase
			end
			#if city.chomp.downcase == "cea"
			#	puts key
			#end
		end
	end
end
lake_file = File.read "./euro-lakes.txt"
lake_array = []
lake_file.lines.each do |line|
	if line.chomp.length <= 6
		lake_array << remove_accents(line.chomp.downcase)
	end
end

big_name_array = []
#serial killers often have three names
killer_file = File.read "./serial-killers.csv"
killer_array = []
killer_file.lines.each do |line|
	just_name = line.split(",")[0].chomp.downcase.gsub(/[^a-z ]/, '')
	if just_name.split.length == 3
		killer_array << just_name.chomp.downcase
		big_name_array << just_name.chomp.downcase
	end
end
people_file = File.read "./famous-people.txt"
people_array = []
people_file.lines.each do |line|
	initial = line.split(',')
	person_name = initial[1]
	if person_name.split.length == 3
		people_array << person_name.chomp.downcase
		big_name_array << person_name.chomp.downcase
	end
end
people_file = File.read "./famous-people-2.txt"
people_array = []
people_file.lines.each do |line|
	if line.split.length == 3
		people_array << line.chomp.downcase
		big_name_array << line.chomp.downcase
	end
end
#wikipedia-scraped actor names
celebrity_file = File.read "current-legislators.txt"
celebrity_array = []
celebrity_file.lines.each do |line|
	#remove numbers and things between parentheses (eg: "(comedian)")
	just_name = line.gsub(/\([^()]*\)/, '')
	just_name.gsub("-", " ")
	just_name.gsub!(/[^a-zA-z ]/, '')
	if just_name.chomp.split.length == 3
		celebrity_array << remove_accents(just_name.chomp.downcase)
		big_name_array << remove_accents(just_name.chomp.downcase)
	end
end

combined_array = []
big_name_array.each do |person|
	combined = ""
	person.split.each do |word|
		combined << word[0].downcase
		combined << word[-1].downcase
	end
	combined_array << combined
	#if combined.start_with?('s') 
	#	puts "person: " + person + "    " + "combined: " + combined
	#	puts "---------------------------------------------------------------------"
	#end
end
puts big_name_array.length
puts combined_array.length

=begin
combined_array.each do |combine|
	euro_city_array.each do |city|
		if combine.star_with?(city)
			puts combine
			puts city
			puts "========="
		end
	end
end
=end

#puts combined_array.length
puts "lake and combine match!!!!!" + (lake_array & combined_array).to_s
puts "city combine and lake match!!!!!" + (euro_city_array & combined_array & lake_array).to_s
puts "city and lake match!!!!!" + (euro_city_array & lake_array).to_s
# -> prespa, siljan, geneva


=begin
dictionary_file = File.read "/usr/share/dict/words"
dictionary_array = []
dictionary_file.lines.each do |line|
	dictionary_array << line.chomp.downcase
end

dictionary_array.each do |word|
	if word[0] == 'n' && word[-1] == 'e'
		puts word
	end
end
=end


#surname dataset from https://github.com/fivethirtyeight/data/tree/master/most-common-name
surname_file = File.read "./surnames.csv"
surname_array = []
surname_file.lines.each do |line|
	temp = line.split(',')
	just_name = temp[0].downcase.chomp
	if just_name[0] == 'e' && just_name[-1] == 's'
		surname_array << just_name
	end
end
puts surname_array

#I feel like the answer has to be Geneva but can't figure out the name
name_file = File.read "./us-first-names.txt"
name_array = []
name_file.lines.each do |word|
	if word.chomp.downcase[0] == 'g' && word.chomp.downcase[-1] == 'e'
		name_array << word.chomp.downcase
	end
end
#puts name_array

big_name_array.each do |person|
	if person.split[2].start_with?('p') && person.split[2].end_with?('a')
		puts person
	end
end

#this probably isn't what they were looking for, but Mariano Di Vaio (Mo, Norway + Lake Divo, Russia) is technically a solution