=begin
Think of a two-word direction or command. Take the first letter of the first word plus the entire second word, in order, and you'll get a common name for one receiving that direction or command. What is it?

ex:
word1 word2  word3
Paws  up,    pup!

1. word3 must be a noun
2. dictionary must include word3[1..-1]
3. word1 must be a verb(probably imperative?)
4. word2 must be an adjective or verb(?)
5. word2 = word3[1..-1]

The first letter requirement for word1 is the broadest one, so it's probably best to work backward starting from valid word3s

=end

=begin
****only run once to build valid noun file****
puts "Building dictionaries...."
dictionary_file = File.read "/usr/share/dict/words"
dictionary_array = []
dictionary_file.lines.each do |line|
	dictionary_array << line.chomp.downcase
end
noun_file = File.read "./nouns.txt"
noun_array = []
noun_file.lines.each do |line|
	noun_array << line.chomp.downcase
end

puts "Checking if dictionary includes part of noun...."
solutions = []
noun_array.each do |noun|
	if dictionary_array.include?(noun[1..-1])
		solutions << noun
		puts noun
	end
end

puts "Writing to file...."
File.open("./valid-nouns.txt", "w+") do |f|
	solutions.each{ |noun| f.puts(noun) }
end
=end

noun_file = File.read "./valid-nouns.txt"
noun_array = []
noun_file.lines.each do |line|
	noun_array << line.chomp.downcase
end
#dumb de-lemmatizing
noun_array.each do |noun|
	if noun_array.include?(noun[0..-2]) || noun.end_with?('s')
		noun_array.delete(noun)
	end
	if noun_array.include?(noun[0..-3]) || noun.end_with?('es')
		noun_array.delete(noun)
	end
	if noun_array.include?(noun[0..-4]) || noun.end_with?('ing')
		noun_array.delete(noun)
	end
end

solutions = []
noun_array.each do |noun|
	solutions << noun[0] + "_____  " + noun[1..-1] + "  " + noun
end

puts "Writing to file...."
File.open("./valid-solutions.txt", "w+") do |f|
	solutions.each{ |line| f.puts(line) }
end

=begin
do evil
make aid
soldier on

are the best solutions I can find for the time being
=end