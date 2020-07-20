#Think of a six-letter word for something you might wear. Insert an O in the exact middle, and you'll get a phrase meaning not aware. What is it? So again, a six-letter word for something you might wear. Insert an O in the exact middle, and you'll get a phrase meaning not aware. What phrase is it?

#outfit -> out of it

dictionary_file = File.read "/usr/share/dict/words"
dictionary_array = []
dictionary_file.lines.each do |line|
	if line.chomp.length == 6 && !line.include?('\'')
		if line.chomp[3] == 'n' || line.chomp[3] == 'f' 
			dictionary_array << line.chomp.downcase
		end
	end
end
puts dictionary_array.length
puts dictionary_array