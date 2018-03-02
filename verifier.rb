#Austin Linder & Jacqueline Marx
#Deliverable 3 CS 1632

require_relative 'block' 

#MAIN PROGRAM EXECUTION
raise "Enter input file" unless ARGV.count == 1

input_file = ARGV[0]

lines_array = []

#Reads blockchain file and splits each line into a string representation of a block in the block array
lines_array = File.readlines(input_file)

#Number of blocks in the file
num_blocks = lines_array.count 

#Make array of block objects to perform actions on
blocks_array = []
fields_array = []

#Create block objects for array, seperate fields
i = 0
while i < num_blocks  do
   fields_array = lines_array[i].split('|')
   blocks_array[i] = Block.new(fields_array[0],fields_array[1],fields_array[2],fields_array[3],fields_array[4])
   i += 1
end

blocks_array[0].validate_block





