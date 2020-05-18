#Name a Cabinet department, as in department of blank. Rearrange the letters of what goes in the blank to get the brand name of a product you might buy at a drugstore or a supermarket. What is it? So again, a Cabinet department - rearrange the letters to get the brand name of a product you might buy at a drugstore or a supermarket. What product is it?

require 'roo'

def anagram_checker(word1, word2)
	#delete whitespace, non-alphanum chars
	word1.gsub!(/\W+/, '')
	word2.gsub!(/\W+/, '')

	return word1.split('').sort.join == word2.split('').sort.join
end

department_array = ["state", "treasury", "defense", "justice", "interior", "agriculture", "commerce", "labor", "health and human services", "housing and urban development", "transportation", "energy", "education", "veterans affairs", "homeland security"]



#grocery brand database from http://www.grocery.com/open-grocery-database-project/
brand_sheet = Roo::Spreadsheet.open './Grocery_Brands_Database.xlsx'
#Column B contains brand names
brands = brand_sheet.column(2)
brand_array = []
brands.each do |brand|
	brand_array << brand.chomp.downcase
end

department_array.each do |department|
	brand_array.each do |brand|
		if anagram_checker(department.chomp.downcase, brand.chomp.downcase)
			puts "department: " + department + "    " + "brand: " + brand
		end
	end
end

=begin
class String
  def all_possible_permutations
    self.chars.to_a.permutation.map(&:join)
  end
end

department_array.each do |department|
	puts "================="
	puts department.all_possible_permutations
end
=end

#list of brand names from https://github.com/MatthiasWinkelmann/english-words-names-brands-places.git

brand_file = File.read "./brands.csv"
brand_array = []
brand_file.lines.each do |line|
		brand_array << line.chomp.downcase
end

department_array.each do |department|
	brand_array.each do |brand|
		if anagram_checker(department.chomp.downcase, brand.chomp.downcase)
			puts "department: " + department + "    " + "brand: " + brand
		end
	end
end

word_file = File.read "/usr/share/dict/words"
word_array = []
word_file.lines.each do |line|
		word_array << line.chomp.downcase
end

department_array.each do |department|
	word_array.each do |brand|
		if anagram_checker(department.chomp.downcase, brand.chomp.downcase)
			puts "department: " + department + "    " + "brand: " + brand
		end
	end
end

#list of CVS brands from cvs.com/shop/brand-directory
brand_file = File.read "./cvs_brands.csv"
brand_array = []
brand_file.lines.each do |line|
		brand_array << line.chomp.downcase
end

department_array.each do |department|
	brand_array.each do |brand|
		if anagram_checker(department.chomp.downcase, brand.chomp.downcase)
			puts "department: " + department + "    " + "brand: " + brand
		end
	end
end

#the answer is Labor -> Oral-B and the lesson here is make sure to remove non-alphanumeric characters