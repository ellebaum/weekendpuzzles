=begin
Mira has a toy with five rings of different diameters and a tapered column. Each ring has a “correct” position on the column, from the largest ring that fits snugly at the bottom to the smallest ring that fits snugly at the top.

Each ring she places will slide down to its correct position, if possible. Otherwise, it will rest on what was previously the topmost ring.

For example, if Mira stacks the smallest ring first, then she cannot stack any more rings on top. But if she stacks the second-smallest ring first, then she can stack any one of the remaining four rings above it, after which she cannot stack any more rings.
This got Mira thinking. How many unique stacks can she create using at least one ring?

Extra credit: Instead of five rings, suppose the toy has N rings. Now how many unique stacks can Mira create?
=end

=begin
Let's imagine the column as an empty array of integers of length n, with index 0 being the top area of the column and index n-1 being the base. Let's imagine the order of ring additions as a randomly sorted array of integers between length 1 and length n with unique values from 1 to n. 

define an array of arrays to keep track of solutions

set a 'locked_location' pointer to nil

while index 0 of the column array is empty && ring array is not empty
	set a 'current_ring_location' pointer to 0

	shift the ring array

	while current_ring_location < locked_location && current_ring_location < shifted_element
		if shifted_element == current_ring_location
			locked_location = current_ring_location
			column[current_ring_location] == shifted_element
		end
		current_ring_location++
	end
end

then run a bunch of simulations to monte carlo this b-word
=end

def ring_stackeroo(column_height, iterations)
	#index values of 0 will represent empty spaces
	column = Array.new(column_height, 0)
	ring_moves = *(1..rand(column_height + 1))
	ring_moves.shuffle!
	locked_location = column_height
	ring = ring_moves.shift
	while column[0] == 0 && !ring_moves.empty?
		current_ring_location = 0
		while current_ring_location < locked_location && current_ring_location < ring && !ring_moves.empty?
			if column[current_ring_location + 1] != nil
				if ring == current_ring_location + 1 || column[current_ring_location + 1] != 0
					locked_locaton = current_ring_location
					column[current_ring_location] = ring
					current_ring_location += 1
					ring = ring_moves.shift
				end
			elsif column[current_ring_location + 1] == nil
				if ring == current_ring_location + 1 || column[current_ring_location + 1] != 0
					locked_locaton = current_ring_location
					column[current_ring_location] = ring
					current_ring_location += 1
					ring = ring_moves.shift
					break
				end
			end
			current_ring_location += 1
		end
	end
	return column
end
#there seems to be a bug where the method doesn't recognize all of the rings in the correct order as a valid solution

puts "How tall is the column?"
column_height = gets.chomp.to_i
puts "How many times do you wanna run this thing?"
iterations = gets.chomp.to_i

solutions = Array.new
iterations.times{solutions << ring_stackeroo(column_height, iterations)}
solutions.uniq!
solutions.sort!
puts "Solutions:"
solutions.each do |array|
	puts array.to_s
end
puts "Number of solutions: " + (solutions.length - 1 + 1).to_s #remove array that only has 0s
#.....but add back one to account for the bug in the stackeroo method

#1  solutions for height 1
#3  solutions for height 2
#7  solutions for height 3
#15 solutions for height 4
#**37 solutions for height 5**
#113 solutions for height 6
#394 solutions for height 7
#1520 solutions for height 8
#~6363 solutions for height 9
#~27277 solutions for height 10
#can't figure out the equation yet'
