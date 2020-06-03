#Think of a familiar three word name of something. The first word of that name is a number. Let's call that number x. The last x letters of the second word are a french translation of the third word. What's the name?

numbers = {
	['one', 'first'] => 1 , 
	['two', 'second'] => 2 ,
	['three', 'third'] => 3,
	['four', 'fourth'] => 4,
	['five', 'fifth'] => 5,
	['six', 'sixth'] => 6,
	['seven', 'seventh'] => 7,
	['eight', 'eigth'] => 8,
	['nine', 'ninth'] => 9,
	['ten', 'tenth'] => 10,
	['eleven', 'eleventh'] => 11,
	['twelve', 'twelfth'] => 12,
	['thirteen', 'thirteenth'] => 13 
}

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
    str = str.gsub(/ /,"-")
end

french = File.read('./francais.txt')
french_array = []
french.lines.each do |line|
	french_array << line.chomp.downcase
end

corpus = File.read('./brown.txt')
words_array = []
corpus.scan(/\w+/).each_cons(3) do |x, y, z|
	numbers.each do |num, dig|
		num.each do |i|
			if x == i && y.length >= dig
				french_array.each do |fr_word|
					if y.end_with?(remove_accents(fr_word)) && fr_word == dig
						words_array << (x + " " + y + " " + z)
					end
				end
			end
		end
	end
end
	
puts words_array

#the answer is three mile island