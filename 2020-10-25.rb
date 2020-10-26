#What common seven-letter verb is made up of three consecutive musical notes in order?

#defaced? (d + fa + si + d)

cmu_dict_file = File.read "./cmudict.dict" #Carnegie Mellon Pronouncing Dictionary
cmu_dict_hash = Hash.new{|k, v| k[v] = []}
cmu_dict_file.lines.each do |line|
	word = line.split[0].chomp
	ipa = line.split[1..-1]
	ipa.each do |sound|
		sound.gsub!(/[^a-zA-Z]/,'')
	end
	if word.gsub(/[^a-zA-Z]/,'').length == 7
		cmu_dict_hash[word].push(ipa)
	end
end

#do re mi fa sol la si/ti do
#c  d  e  f  g   a  b     c

music_notes = [["D","OW"], ["R","EY"], ["M","IY"], ["F","AA"], ["S","OW"], ["L","AA"], ["T","IY"], ["S", "IY"], ["D","OW"]]

other_notes = "abcdefg".chars
other_notes << "db" 
other_notes << "eb"
other_notes << "gb"
other_notes << "ab"
other_notes << "bb"

other_other_notes = [["S", "IY"], ["D", "IY"], ["IY"], ["EH", "F"], ["JH", "IY"], ["EY"], ["B", "IY"]] 

cmu_dict_hash.each do |k, v|
	ipa_by_two = []
	v.flatten!
	v.each_slice(2) do |sound|
		ipa_by_two << sound
	end
	if ipa_by_two.length == 3
		matches = 0
		ipa_by_two.each do |sound|
			if music_notes.include?(sound)
				matches += 1
			end
		end
		if matches >= 2
			puts k
		end
	end
	matches = 0
	k.gsub(/[^a-zA-Z]/,'').chars.each do |letter|
		if other_notes.include?(letter)
			matches += 1
		end
		if matches >= 7
			puts k
		end
	end
end
=begin
=>
acceded
babbage
baggage
baggage(2)
bilotti
cabbage
cabbage(2)
cdebaca
collado
defaced
fogerty
fossey's
galassi
galasso
galotti
la-carre
labarre
lacasse
lacosse
lafarge
lagasse
larusso
lassila
lockamy
meatier
meteors
milazzo
minniti
petitti
racemes
sealock
solazzo
=end