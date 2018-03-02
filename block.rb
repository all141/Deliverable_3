#Austin Linder & Jacqueline Marx
#Deliverable 3 CS 1632
# Block Class
# Holds all the values that a block  in a Billcoin blockchain has
require_relative 'transaction'
require_relative 'address'

class Block
	#Block Number
	@block_number
	
	#Hash of the previous block in the chain
	@previous_hash
	
	#Sequence of transactions in block
	@transaction_sequence
	
	#Array of transactions in a block
	@transaction_array
	
	#Number of transactions in the block
	@num_transactions
	
	#Timestamp
	@timestamp
	
	#Hash of current block
	@current_hash
	
	#Constructor
	def initialize(b,p,s,t,h)
		@block_number = b
		@previous_hash = p
		@transaction_sequence = s
		@transaction_array = seperate_transactions
		@num_transactions = (@transaction_array.count / 3)
		finalize_transactions
		remove_duplicate_addresses
		@timestamp = t
		@current_hash = h
	end
	
	#Take string of transactions and interpret individual transactions
	def seperate_transactions
		@transaction_sequence.split(/\W+/)
	end
	
	#Take array of delimited transaction criteria, organize them into transaction object, and store them in a new array
	def finalize_transactions
		i = 0
		j = 0
		#Array containing transaction objects
		@transaction_final = Array.new
		@address_array = Array.new #holds the name of every to and from address including duplicates
		until i > @num_transactions
			@transaction_final[i] = Transaction.new(@transaction_array[i],@transaction_array[i+1],@transaction_array[i+2])
			@address_array[i-j] = Address.new(@transaction_array[i].strip)
			@address_array[i+1-j] = Address.new(@transaction_array[i+1].strip)
			i += 3
			j += 1
		end
	end	
	
	#Removes duplicate addresses
	#DOESN'T WORK YET HENRY REPEATS
	def remove_duplicate_addresses
		@address_array = @address_array.uniq
		puts "address_array: #{@address_array[0].get_name}"
		puts "address_array1: #{@address_array[1].get_name}"
		if @address_array[2].nil?
		else
			puts "address_array2: #{@address_array[2].get_name}"
		end
		if @address_array[3].nil?
		else
			puts "address_array3: #{@address_array[3].get_name}"
		end
		if @address_array[4].nil?
		else
			puts "address_array4: #{@address_array[4].get_name}"
		end
		if @address_array[5].nil?
		else
			puts "address_array5: #{@address_array[5].get_name}"
		end
		if @address_array[6].nil?
		else
			puts "address_array6: #{@address_array[6].get_name}"
		end
		if @address_array[7].nil?
		else
			puts "address_array7: #{@address_array[7].get_name}"
		end
		if @address_array[8].nil?
		else
			puts "address_array8: #{@address_array[8].get_name}"
		end
		if @address_array[9].nil?
		else
			puts "address_array9: #{@address_array[9].get_name}"
		end
		
		
	end
	
	#Print all fields given from the input file
	def print_initial_fields
		puts "block_number: #{@block_number}"
		puts "previous_hash: #{@previous_hash}"
		puts "transaction_sequence: #{@transaction_sequence}"
		puts "timestamp: #{@timestamp}"
		puts "current_hash: #{@current_hash}"
	end
	
	#A hash of the first four elements, method provided by laboon
	#Creates current_hash, compare this to given current hash to see if an issue exists
	def create_hash
		utf_array = Array.new
		utf_sum = 0
		utf_mod = 0
		@calculated_hash = ""
		string_to_hash = "#{@block_number}|#{@previous_hash}|#{@transaction_sequence}|#{@timestamp}"
		utf_array = (string_to_hash.unpack('U*'))
		utf_array.map! do |x| (x ** 2000) * ((x + 2) ** 21) - ((x + 5) ** 3) end 
		utf_sum = utf_array.inject(0){|sum,x| sum + x }
		utf_mod = utf_sum % 65536
		@calculated_hash = utf_hex = utf_mod.to_s(16)
	end
	
	#Compares the given hash with the calculated hash
	def compare_current_hash
		@calculated_hash = create_hash
		if @current_hash.strip.eql? @calculated_hash.strip
			return 1
		else
			return 0
		end
	end
	
	#Checks to see if the current block is valid
	#NEEDS MORE CONDITIONS
	def validate_block
		valid_flag = 1
		if compare_current_hash == 0
			return 0
		else
			puts "Block is valid! :)"
			return 1
		end
	end
		
	
	#GETTERS
	def get_block_number
		return @block_number
	end
	
	def get_previous_hash
		return @previous_hash
	end
	
	def get_transaction_sequence
		return @transaction_sequence
	end
	
	def get_transaction_array
		return @transaction_array
	end
	
	def get_num_transactions
		return @num_transactions
	end
	
	def get_timestamp
		return @timestamp
	end
	
	def get_current_hash
		return @current_hash
	end
	
	def get_calculated_hash
		return @calculated_hash
	end
	
	def get_transaction_final
		return @transaction_final
	end
	
	def get_address_array
		return @address_array
	end
	
	#SETTERS
	def set_block_number(b)
		@block_number = b
	end
	
	def set_previous_hash(p)
		@previous_hash = p
	end
	
	def set_transaction_sequence(s)
		@transaction_sequence = s
	end
	
	def set_timestamp(t)
		@timestamp = t
	end
	
	def set_current_hash(c)
		@current_hash = c
	end
end
