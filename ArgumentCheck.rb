class ArgumentCheck

	# This method will verify that the number of arguments if 1
	# When a valid number of arguments is passed in a 1 will be returned.
	# Otherwise a -1 will be returned
	def argumentsEqual len
		if len == 1
			return 1
		else
			return -1
		end
	end
	
	# This method will check that the file exists
	# If the file exists a 1 will be returned otherwise a -1 will be returned
	def fileChecker filename
		if(File.exist?(filename))
			return 1
		else
			return -1
		end
	end

end