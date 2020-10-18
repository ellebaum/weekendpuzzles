#Name a world capital. Change one letter in it to D-Y. The result will be two words, one after the other. The first word names somebody you like to be around. The second word names somebody you don't like to be around. What city is it?

#Budapest => buddy, pest

require 'json'

capital_file = File.read "./world_capitals.json"
capitals = JSON.parse(capital_file)
capital_hash = Hash.new

capitals.each do |line|
	line.each do |k, v|
		if k == "city" && v
			city = v.gsub(/[^a-zA-Z]/,'').chomp.downcase
			total = 0
			city.chars.each do |char|
				total += char.ord
			end
			capital_hash.store(city, total)
		end
	end
end

dict_file = File.read "/usr/share/dict/words"
dict_hash = Hash.new
dict_file.lines.each do |line|
	word = line.gsub!(/[^a-zA-Z]/,'').chomp.downcase
	if line.length >= 3
		total = 0
		word.chars.each do |char|
			total += char.ord
		end
	end
	if total
		dict_hash.store(word, total)
	end
end

#target has one more D and one more Y than capital
#capital has one D fewer and one Y fewer and one more unknown letter than capital
#a.ord = 97
#b.ord = 98
#d.ord = 100
#y.ord = 121
#d.ord + y.ord = 221 
#99 <= target.ord - capital.ord <= 124
#symmetric union with duplicates(?) includes d, y, and one unknown third letter

class Array
	def dup_difference(other)
    	cpy = dup
    	other.each do |e|
      		ndx = cpy.rindex(e)
      		cpy.delete_at(ndx) if ndx
    	end
    	cpy
  	end
end

def union(a,b)
  (a|b).flat_map { |s| [s]*[a.count(s), b.count(s)].max }
end

capital_hash.each do |cap_k, cap_v|
	dict_hash.each do |w1_k, w1_v|
		dict_hash.each do |w2_k, w2_v|
			target_ord = w1_v + w2_v
			if target_ord - cap_v >= 99 && target_ord - cap_v <= 124
				target = w1_k + w2_k
				tar_to_c = target.chars
				cap_to_c = cap_k.chars
				set_diff = union(cap_to_c.dup_difference(tar_to_c), tar_to_c.dup_difference(cap_to_c))
				if set_diff.length == 3 && set_diff.include?("d") && set_diff.include?("y")
					#todo
					#target.length - capital.length == 1
					#check for intances substring "dy" in target word
					#for each instance of "dy", remove the "y"
					#if capital and target have a matching sequence of capital.length - 1 characters, add to solutions
					puts cap_k + ":  " + w1_k + ",  " + w2_k
				end
			end
		end
	end
end