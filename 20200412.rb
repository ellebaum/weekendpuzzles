#Create the shortest possible word ladder, connecting "large" to "small", changing one letter at a time, making a common uncapitalized word along the way. Plurals and verbs formed by adding 's' are not allowed.

#Thoughts: Take a dictionary, remove all words that are not 5 letters, then remove all words that do not contain an 'a', 'e', 'g', 'l', 'm', 'r', or 's'. I think any word that ends in 's' could also be removed but there might be edge cases. After that, run a word ladder algo and examine the results!

dictionary = []
file = File.read "/usr/share/dict/words"
file.lines.each do |line|
	line.downcase.chomp
	if(line.include?("a") || line.include?("e") || line.include?("g") || line.include?("l") || line.include?("m") || line.include?("r") || line.include?("s"))
			dictionary << line
	end
end

new_dict = []

dictionary.each do |word|
	if word.length == 6
		word.chomp
		if not word.end_with?('s')
			new_dict << word
		end
	end
end


#puts dictionary
#puts dictionary.length

#puts new_dict
#puts new_dict.length

word_dict = []
new_dict.each do |word|
	word_dict << word.chomp
end


def off_by_one(string1, string2)
	
	array1 = []
	array2 =[]

	string1.split("").each do |char|
		array1 << char
	end

	string2.split("").each do |char|
		array2 << char
	end
	
	i = array1.zip(array2).count { |a,b| a == b }
	if (string1.length - i) == 1
		result = TRUE
	else
		result = FALSE
	end

	return result
end

=begin
def word_ladder(start_word, end_word, dictionary)

	queue = [[start_word]]
	visited_words = [start_word]
	stack_check = ""

	dictionary.each do |word|
		if off_by_one(start_word, word)
			temp_stack = []
			temp_stack.push start_word
			temp_stack.push word
			visited_words.push word
			queue.unshift temp_stack
		end
	end

	while (!queue.empty? || !stack_check.eql?(end_word))
=begin
		for word in visited_words
			if dictionary.include?(word)
				dictionary -= [word]
			end
		end

		queue_check = queue.shift
		puts "queue check: " + queue_check.to_s.chomp

		stack_check = queue_check.last

		if stack_check.eql?(end_word)
			puts queue
		else
			dictionary.each do |word|
				if off_by_one(stack_check, word)
					temp_stack = []
					#temp_stack.push start_word
					temp_stack.push word
					visited_words.push word
					dictionary.delete(word)
					queue.unshift temp_stack
					puts temp_stack
					puts "------"
					#puts visited_words
					puts "!!!!!!!!!!!!!!!"
					puts visited_words.length
					puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11"
				end
			end
		end
	end
end
=end
#word_ladder("large", "small", word_dict)

=begin
test_dict = ["stone", "store", "chore", "choke", "choky", "cooky", "cooey", "coney", "money", "atone", "alone", "clone"]
#puts word_ladder("stone", "money", test_dict)
word_dict = test_dict
start_word = "stone"
end_word = "money"
=end

start_word  = "large"
end_word    = "small"
word_dict   = new_dict

queue = []
temp_stack = []
visited_words = []
visited_words.push start_word

word_dict.each do |word|
	word.downcase.chomp
	if off_by_one(start_word, word)
		if !visited_words.include?(word)
			temp_stack = []
			temp_stack.push start_word
			temp_stack.push word
			visited_words.push word
			queue.unshift temp_stack
		end
	end
end

while (queue.length > 0)
	queue_check = queue.shift
	stack_check = queue_check.last
	puts "stack check " + stack_check.to_s
	if stack_check.eql?(end_word)
		puts queue_check
	else
		word_dict.each do |word|
			word.to_s.downcase.chomp
			if off_by_one(stack_check, word)
				if !visited_words.include?(word)
					visited_words.push word
					temp_stack2 = temp_stack
					temp_stack2.push word
					queue.unshift temp_stack
				end
			end
		end
	end
end

=begin
for item in queue
	puts item
	puts "===================="
end
=end

puts "!!!!!!!!!!!!!!!!!!!!!!!!"
puts visited_words
