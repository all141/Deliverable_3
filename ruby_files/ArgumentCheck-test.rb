require 'minitest/autorun'

require_relative "ArgumentCheck"

class ArgumentCheckTest < Minitest::Test

	def setup
		@checkArgs = ArgumentCheck::new
	end
	
	# This unit test with check that a  number of arguments that 
	# is less than 1 shows an error (-1) result.
	# This method should return -1
	# EDGE CASE
	def test_argumentsLengthUnderOne
		assert_equal -1, @checkArgs.argumentsEqual(0)
	end
	
	# This unit test will check that a arguments number of 1 results in a 1.
	# This method should result in a 1.
	# EDGE CASE
	def test_argumentsLengthIsOne
		assert_equal 1, @checkArgs.argumentsEqual(1)
	end
	
	# This unit test checks a number of arguments greater than 1 returns -1.
	# This method should result in -1.
	# EDGE CASE
	def test_argumentsLengthAboveOne
		assert_equal -1, @checkArgs.argumentsEqual(2)
	end
	
	# This unit will be to check if the file exists method works
	# In order to run this test you cannot have a file called "lottery.txt"
	# If "lottery.txt", return -1
	# If "ArugumentCheck.rb", return 1
	
	
	def test_FileNotExist
		assert_equal -1, @checkArgs.fileChecker("lottery.txt")
	end
	
	def test_FileExists
		assert_equal 1, @checkArgs.fileChecker("ArgumentCheck.rb")
	end
	
end
