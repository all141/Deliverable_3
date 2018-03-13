#Austin Linder & Jacqueline Marx
#Deliverable 3 CS 1632
require 'flamegraph'

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

def verifyFormat block, line

	# Check the number of arguments in the line
	lineSplit = line.split("|")
	if (lineSplit.length != 5)
		puts "Line #{@number}: Line #{@number} has #{lineSplit.length} args. It should be 5."
        return -1
	end
	
	# Check that the blocks are in order
	if block.get_block_number() != @number.to_s
		puts "Line #{@number}: The block #{@number} is block number #{block.get_block_number()}. The block and line number should match."
        return -1
	end
	
	# Check if the hashes are in the right form
	if (block.get_current_hash() =~ /^([0-9]|[a-f]){1,4}$/) == nil
		puts "Line #{@number}: The current #{block.get_current_hash()} on line #{@number} is bad."
        return -1
	end
	
	if (block.get_previous_hash() =~ /^([0-9]|[a-f]){1,4}$/) == nil
		puts "Line #{@number}: The previous #{block.get_previous_hash()} on line #{@number} is bad."
        return -1
	end
	
	transactions = block.get_transaction_sequence
	trans = transactions.split(":")
	
	trans.each{ |one_transaction|
		from = one_transaction.split(">")[0]
		to = one_transaction.split(">")[1].split("(")[0]
		
		if (/^[A-z]{1,6}$/ =~ from) == nil
			puts "Line #{@number}: The sender '#{from}' on line #{@number} is invalid."
            return -1
		elsif (/^[A-z]{1,6}$/ =~ to) == nil
			puts "Line #{@number}: The recipient '#{to}' on line #{@number} is invalid."            
            return -1
		end
	}
	
	if @number == 0
        if (transactions =~ /^SYSTEM>[A-z]{1,6}\([0-9]+\)$/) == nil
            puts "Line #{@number}: The first block does not contain exactly one transaction the gives money from the SYSTEM to a valid user."
            return -1
        end
    end
	
	if (transactions =~ /^(([A-z]{1,6}>[A-z]{1,6}\([0-9]+\))(:[A-z]{1,6}>[A-z]{1,6}\([0-9]+\))*(:SYSTEM>[A-z]{1,6}\([0-9]+\))$)|(^SYSTEM>[A-z]{1,6}\([0-9]+\))$/) == nil
        puts "Line #{@number}: Block #{number} is bad. Check that there is no invalid characters and the last transaction is SYSTEM to a good user."
        return -1;
    end
	
	# Check the timestamp
	if (block.get_timestamp() =~ /^[0-9]+.[0-9]+$/) == nil
        puts "Line #{@number}: The timestamp #{block.get_timestamp()} is invalid."
        return -1
    end
	
    return 1
	
end

def verifyBalance block
	transactions = block.get_transaction_sequence
	trans = transactions.split(":")
	
	trans.each{ |one_transaction|
		from = one_transaction.split(">")[0]
		to = one_transaction.split(">")[1].split("(")[0]
		amount = one_transaction.split(">")[1].split("(")[1].split(")")[0].to_i
		
		if @totals[to] == nil
			@totals[to] = amount
		else
			@totals[to] += amount
		end
		
		unless from == "SYSTEM"
			if @totals[from] == nil
				@totals[from] = amount * -1
			else
				@totals[from] -= amount
			end
		end
	}
	
	@totals.each { |t|
		if t[1] < 0
			puts "Line #{@number}: Invalid block: After block #{@number} #{t[0]} has #{t[1]} billcoins."
			return -1
		end
	}
	
	return 1
end

def verifyTime block
	if @previous_line == ""
		return 1
	end
	
	old_time = @previous_line.split("|")[3]
	new_time = block.get_timestamp()
	
	if new_time.split(".")[0].to_i > old_time.split(".")[0].to_i
		return 1
	end
	
	if new_time.split(".")[0].to_i == old_time.split(".")[0].to_i
		if new_time.split(".")[1].to_i > old_time.split(".")[1].to_i
			return 1
		end
	end
	
	puts "Line #{@number}: Previous timestamp #{old_time} >= new timestamp #{new_time}"
	return -1
end

def verifyHash block
	
	totalFields = 0
	
	if @number != 0
		if @previous_line.split("|")[4].split("\n")[0] != block.get_previous_hash()
			puts "Line #{@number}: The hash of block #{@number - 1} stored on line #{@number} does not match. #{block.get_previous_hash()} =/= #{@previous_line.split("|")[4].split("\n")[0]}"
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
    puts "Line #{@number}: The hash calculated for block #{@number} did not match the stored hash. #{block.get_calculated_hash()}=/=#{block.get_current_hash()}"
    return -1
	
end

Flamegraph.generate('verifiergraph.html') do

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
	   
	   if verifyFormat(current_block, lines_array[i]) == -1
		puts "BLOCKCHAIN INVALID"
		exit
	   elsif verifyTime(current_block) == -1
		puts "BLOCKCHAIN INVALID"
		exit	
	   elsif verifyBalance(current_block) == -1
		puts "BLOCKCHAIN INVALID"
		exit
	   elsif verifyHash(current_block) == -1
		puts "BLOCKCHAIN INVALID"
		exit
	   end
	   
	   # Update the previous_line to the current line if all checks have passed   
	   @previous_line = lines_array[i]
	   @number += 1
	   i += 1
	end

	@totals.each { |t|
		puts "#{t[0]} : #{t[1]} billcoins"
	}
end