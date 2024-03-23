income_from_record:
#function to return numerical income from a specific record
#e.g. for record "Microsoft,34\r\n", income to return is 34(for which name is Microsoft)

#arguments:	a0 contains pointer to start of numerical income in record 

#function RETURNS income numerical value of the asci income in a0 (34 in our example)
	
# Start your coding from here!

	#li a0, 0 # income_from_record function
	#if no student code entered, a0 just returns 0 always :(
	
	li t0, 13 # '/r', ASCII code of "carriage return" character
	
	li t1, 10 # multiplication factor, to use later
	
	lbu t2, 0(a0) # load the first character in file

	
	
	bne t2, t0 incomeLoop #check that character is not a comma (which would indicate the end of the income data)
	li a0, 0
	ret
	
incomeLoop:
	
	addi a0, a0, 1 # increment pointer location by 1 byte
	lbu t3, 0(a0) # load the next character in file
	
	bne t3, t0 mulLoop
	addi a0, t2, 0
	ret
	
mulLoop:

	mul t2, t2, t1
	add t2, t2, t3
	j incomeLoop
	
	
	
	
	
# End your  coding  here!
	ret
	
#######################end of income_from_record###############################################	
