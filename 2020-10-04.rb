#Think of an 8-letter word with three syllables that contains the letter "I" in each syllable — but, strangely, doesn't contain a single "I" sound, either long or short. The answer is not a plural. What word is it?

#answer: daiquiri

solutions = []
cmu_dict_file = File.read "./cmudict/cmudict.dict" #Carnegie Mellon Pronouncing Dictionary
cmu_dict_file.lines.each do |line|
	word = line.split[0].gsub(/[^a-z]/, '')
	ipa = line.split[1..-1]
	ipa.each do |sound|
		sound.gsub!(/[^A-Z]/, '')
	end
	if word.length == 8
		i_count = 0
		word.chars.each do |char|
			if char == 'i'
				i_count += 1
			end
		end
		if i_count >= 3 && !ipa.include?("IH") && !ipa.include?("AY")#"short i" == IH, "long i" == AY
			solutions << word
		end
	end
end

puts solutions.to_s
# => ["biaggini", "biagioni", "caminiti", "chinnici", "cipriani", "daiquiri", "dominici", "giannini", "giardini", "giuliani", "guiliani", "librizzi", "nicolini", "pistilli", "ricciuti", "siddiqui", "tomiichi"]