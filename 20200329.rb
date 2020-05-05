# Challenge: "Think of a world capital. Drop the third and fourth letters. The remaining letters in order will name a state"

#Thoughts: It's an april fools puzzle so "state" may refer to an unobivious category (e.g.: emotional state, physical state, state of existence)

#Process: Structure a list of countries and their capitals. Form a list with the letters removed. Remove invalid words. Examine results!

require 'json'
file=File.read "./countriesAndCapitals.json"
countriesAndCapitals = JSON.parse(file)
dropped_array = []

countriesAndCapitals.each do |i|
	capital = countriesAndCapitals.shift
	capital_s = capital["CapitalName"]
	capital_s[2, 2] = '' #I don't understand why this isnt [2,3] but [2,2] works properly
	dropped_array << capital_s.downcase.chomp
end

words_array = []
file = File.read "/usr/share/dict/words"
file.lines.each do |line|
	words_array << line.downcase.chomp
end

puts (words_array & dropped_array) #"being" is the only sensible answer!
