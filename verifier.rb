#Austin Linder & Jacqueline Marx
#Deliverable 3 CS 1632

#MAIN PROGRAM EXECUTION
raise "Enter input file" unless ARGV.count == 1

input_file = ARGV[0]

blocks_array = []

#Reads blockchain file and splits each line into a string representation of a block in the block array
File.open(input_file, "r").each_line do |blocks_array|
	puts "blocks_array[0]: #{blocks_array[0]}" 
end


