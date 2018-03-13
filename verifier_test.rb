#Austin Linder & Jacqueline Marx
#Deliverable 3 CS 1632

require 'minitest/autorun'
require_relative 'verifier'

class Verifier_test < Minitest::Test

	#Tests to see if transactions are split properly.
	def test_seperate_transactions
		s = "Addr1<Addr2(100):Addr3<Addr4(500)"
		tb = Block.new(0,0,s,0.0,"90a2")
		arr = tb.get_transaction_array
		assert_equal(["Addr1","Addr2","100","Addr3","Addr4","500"], arr)
	end

end