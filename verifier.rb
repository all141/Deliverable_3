#Austin Linder & Jacqueline Marx
#Deliverable 3 CS 1632

require_relative 'block' 
require_relative 'ArgumentCheck'

@checkArgs = ArgumentCheck::new

@previous_line = ""
@number = 0

@totals = Hash.new

result = @checkArgs.argumentsEqual(ARGV.count)

if(result == -1)
	puts "Enter an input file"
	exit
end

input_file = ARGV[0]

result = @checkArgs.fileChecker(input_file)

if(result == -1)
	puts "That file does not exist"
	exit
end

def verifyHash block
	
	totalFields = 0
	
	if @number != 0
		if @previous_line.split("|")[4].split("\n")[0] != block.get_previous_hash()
			puts "Line #{@number}: The hash of block #{@number - 1} stored on line #{@number} does not match. #{block.get_previous_hash()} =/= #{@previous_line.split("|")[4].split("\n")[0]}."
			return -1
		end
	else
		if block.get_previous_hash() != "0"
			puts "Line #{@number}: The previous hash stored in the first block is not equal to 0."
            return -1
		end
	end
	
    if  block.compare_current_hash() == 1
        return 1
    end
    puts "Line #{@number}: The hash calculated for block #{@number} did not match the stored hash. #{block.get_calculated_hash()}=/=#{block.get_current_hash()}."
    return -1
	
end

lines_array = []

#Reads blockchain file and splits each line into a string representation of a block in the block array
lines_array = File.readlines(input_file)

#Number of blocks in the file
num_blocks = lines_array.count 

#Make array of block objects to perform actions on
fields_array = []

#Create block objects for array, seperate fields
i = 0
while i < num_blocks  do
   fields_array = lines_array[i].split('|')
   current_block = Block.new(fields_array[0],fields_array[1],fields_array[2],fields_array[3],fields_array[4])
   # Do the checks on the current block
   
   if verifyHash(current_block) == -1
	puts "BLOCKCHAIN INVALID"
	exit
   end
   
   # Update the previous_line to the current line if all checks have passed   
   @previous_line = lines_array[i]
   @number += 1
   i += 1
end
