#Name a well-known U.S. city in two words (5,3). Change the first letter of the second word to name a popular rock group. Who is it?

#Green Bay -> Green Day

cities_file = File.read "./us_cities.csv"
city_array = []
cities_file.lines.each do |line|
	city = line.split(",")[0]
	if city.split.length == 2
		city_array << city if city.split[0].length == 5 && city.split[1].length == 3
	end
end

city_array.uniq!

city_array.each do |city|
	puts city
end
=begin
=>
South Lee
Alton Bay
North Jay
Shrub Oak
Round Top
Upper Jay
North Bay
Eagle Bay
Nanty Glo
Broad Top
Lewis Run
Shade Gap
Mount Joy
Cedar Run
Slate Run
Trout Run
Sugar Run
Dover AFB
Broad Run
Gwynn Oak
Royal Oak
Fulks Run
Green Bay
Fancy Gap
Rocky Gap
Mount Gay
Sarah Ann
White Oak
Adams Run
Green Sea
Rabun Gap
Kings Bay
Moody AFB
Eglin AFB
Cedar Key
South Bay
Saint Leo
Grand Bay
Bulls Gap
Tutor Key
Saint Joe
Mount Ayr
Birch Run
White Owl
Minot AFB
Saint Ann
Uncle Sam
Caddo Gap
Mount Ida
Black Oak
Fifty Six
Altus AFB
Pecan Gap
Dyess AFB
Macks Inn
North Rim
Santa Ana
Morro Bay
Monte Rio
Somes Bar
Beale AFB
Scott Bar
Depoe Bay
Pedro Bay
Point Lay	
=end