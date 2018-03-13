#Austin Linder & Jacqueline Marx
#Deliverable 3 CS 1632

require 'minitest/autorun'
require_relative 'block'

class Block_test < Minitest::Test

	#Tests to see if transactions are split properly.
	def test_seperate_transactions
		s = "Addr1<Addr2(100):Addr3<Addr4(500)"
		tb = Block.new(0,0,s,0.0,"90a2")
		arr = tb.get_transaction_array
		assert_equal(["Addr1","Addr2","100","Addr3","Addr4","500"], arr)
	end
	
	# Test to check if the current hash and calculated hash will be compared correctly
	# There will be a test to check two of the same and two different hashes
	# Test with the same hashes, expected result = 1
	# Test with different hashes, expected result = 0
	
	# This will test when the hashes do match
	# The expected result is a 1
	def test_same_hashes
		s = "Addr1<Addr2(100):Addr3<Addr4(500)"
		tb = Block.new(0,0,s,0.0,"90a2")
		tb.set_calculated_hash("90a2")
		
		assert_equal(1, tb.compare_current_hash)
	end
	
	# This test will check for when the hashes do not match
	# The expected result if 0
	def test_different_hashes
		s = "Addr1<Addr2(100):Addr3<Addr4(500)"
		tb = Block.new(0,0,s,0.0,"90a2")
		tb.set_calculated_hash("10b4")
		
		assert_equal(0, tb.compare_current_hash)
	end
	
	# This test will check the calculated value for the number of transactions
	# We will want to ensure that the number of transaction is calculated correctly
	# The result should be 2
	def test_count_transactions
		s = "Addr1<Addr2(100):Addr3<Addr4(500)"
		tb = Block.new(0,0,s,0.0,"90a2")
		
		assert_equal(2, tb.calculate_transaction_count)
	end
	
	# The following test will check that the user can get the result of validate block correctly
	# Then a valid has is passed in the result should be 1
	# The an invalid line is passed in the result should be 0
	
	# This is testing with a valid block
	def test_good_block
		s = "SYSTEM>Gaozu(100)"
		tb = Block.new("0", "0", s, "1518893687.329767000", "fd18")
		
		assert_equal 1, tb.validate_block
	end
	
	# This is testing with an invalid block
	def test_bad_block
		s = "SYSTEM>Gaozu(100)"
		tb = Block.new("0", "0", s, "1518893687.329767000", "fd19")
		
		assert_equal 0, tb.validate_block
	end
	
	# The next method will check that the hash is being calculated correctly
	def test_calc_hash
		s = "SYSTEM>Gaozu(100)"
		tb = Block.new("0", "0", s, "1518893687.329767000", "fd19")
		stringVal = tb.get_calculated_hash
		val = stringVal.strip.eql? "fd18"
		
		assert_equal val, true
	end
	
end