#Austin Linder & Jacqueline Marx
#Deliverable 3 CS 1632
# Block Class
# Holds all the values that a block  in a Billcoin blockchain has
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
	
	#Array containing transaction objects
	@transaction_final
	
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
		@transaction_final = finalize_transactions
		@timestamp = s
		@current_hash = h
	end
	
	#Take string of transactions and interpret individual transactions
	def seperate_transactions
		@transaction_sequence.split(/\W+/)
	end
	
	#Take array of delimited transaction criteria, organize them into transaction object, and store them in a new array
	def finalize_transactions
		until i > @num_transactions
			@transaction_final[i] = Transaction.new(transaction_array[i],transaction_array[i+1],transaction_array[i+2])
			i += 3
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
