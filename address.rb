# A person participating in a transaction and how many billcoins they have
class Address
	#Who is sending billcoins
	@name
	
	#Number of billcoins sent
	@num_billcoins
	
	#Constructor
	def initialize(n,b)
		@name = n
		@num_billcoins = b
	end
	
	#Prints all the fields of the user
	def print_fields
		puts "name: #{@name}"
		puts "num_billcoins: #{@num_billcoins}"
		puts ""
	end
	
	#GETTERS
	def get_name
		return @name
	end
	
	def get_num_billcoins
		return @num_billcoins
	end
	
	#SETTERS
	def set_name(n)
		@from_address = n
	end
	
	def set_num_billcoins(b)
		@num_billcoins = b
	end
end
