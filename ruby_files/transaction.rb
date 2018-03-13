#Austin Linder & Jacqueline Marx
#Deliverable 3 CS 1632
# Transaction Class
# Holds all the values that a transaction in a Billcoin blockchain block has
class Transaction
	#Who is sending billcoins
	@from_address
	
	#Who is receiving billcoins
	@to_address
	
	#Number of billcoins sent
	@num_billcoins
	
	#Constructor
	def initialize(f,t,n)
		@from_address = f
		@to_address = t
		@num_billcoins = n
	end
	
	#Prints all the fields of the transaction
	def print_fields
		puts "from_address: #{@from_address}"
		puts "to_address: #{@to_address}"
		puts "num_billcoins: #{@num_billcoins}"
		puts ""
	end
	
	#GETTERS
	def get_from_address
		return @from_address
	end
	
	def get_to_address
		return @to_address
	end
	
	def get_num_billcoins
		return @num_billcoins
	end
	
	#SETTERS
	def set_from_address(f)
		@from_address = f
	end
	
	def set_to_address(t)
		@to_address = t
	end
	
	def set_num_billcoins(n)
		@num_billcoins = n
	end
end
