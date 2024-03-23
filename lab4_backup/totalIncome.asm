totalIncome:
#finds the total income from the file
#arguments:	a0 contains the file record pointer array location (0x10040000 in our example) But your code MUST handle any address value
#		a1:the number of records in the file
#return value a0:the total income (add up all the record incomes)


# Note: ASCII of  9 is 57; if the character minus 57 is positive, it's not a number.  So don't need to compare with comma,
# comma will be the first that's negative.  WILL have to compare with carriage return as before

	#if empty file, return 0 for  a0
	bnez a1, totalIncome_fileNotEmpty # totalIncome function
	li a0, 0
	ret

totalIncome_fileNotEmpty:
	
	addi sp, sp, -44
	sw, s1, 40(sp)
	sw, s2, 36(sp)
	sw, s3, 32(sp)
	sw, s4, 28(sp)
	sw, s5, 24(sp)
	sw, s6, 20(sp)
	sw, s7, 16(sp)
	sw, s8, 12(sp)
	sw, s9, 8(sp)
	sw, s10, 4(sp)
	sw, s11, 0(sp)
	
	# Start your coding from here!
	#li s4, -48 # we'll be using this to subtract a lot...
	#li s5, -57 # we'll be using this to subtract a lot...
	#li s1, 13 # '\r', ASCII code of "carriage return" character 
	li s1, 44 # '\r', ASCII code of "comma" character
	#addi s1, s1, -48  # subtract 48 from the '\r' ascii code, to compare with numbers
	#add s1, s1, s4  # subtract 48 from the ',' ascii code, to compare with numbers
		
	#lwu a0, 0(a0) #Load the file record pointer array location
	mv s8, a0 #save the initial pointer location
	lwu s11, 0(a0) #Load the file record pointer array location
	mv s10, a1 #save a1, number of records in file
	li s2, 0 # initialize a record counter
	li s3, 0 # initialize the income total sum
	li s4, 0 # initialize a byte counter
	#lbu a4, 0(a0) # load the first character in file

	#crlf
	#crlf
	
	#crlf
	#crlf
	#print_Int(s10)
	#crlf
	#print_int_hex(s8)
	#crlf
	#crlf



#incomeSumLoop: # Maybe... the outer loop?
	blt s2, s10, getIncome 
	
	lw, s1, 40(sp)
	lw, s2, 36(sp)
	lw, s3, 32(sp)
	lw, s4, 28(sp)
	lw, s5, 24(sp)
	lw, s6, 20(sp)
	lw, s7, 16(sp)
	lw, s8, 12(sp)
	lw, s9, 8(sp)
	lw, s10, 4(sp)
	lw, s11, 0(sp)
	addi sp, sp, 44
	
	ret

getIncome:   # get the income for the current record, input as a_
	
	addi sp, sp, -4
	sw, ra, 0(sp)
	jal getIncomeAddress
	lw, ra, 0(sp)
	addi sp, sp, 4
	
	addi sp, sp, -4 #Need to store address pointer points to in a new address, for "income_from_record" to load
	sw s11, 0(sp)
	mv a0, sp
	
	addi sp, sp, -4
	sw, ra, 0(sp)
	jal income_from_record #income from record will be returned in a0, next character (not cr of lf) in a2
	lw, ra, 0(sp)
	addi sp, sp, 4
	
	add s3, s3, a0 # add to the running sum
	
	#add s6, a0, a2
	#add s6, a0, a2
	#mv s5, a2
	
	mv s11, a2 # shift record pointer to the next record title, using output from "income_from_record"
	addi s2, s2, 1 # increment the record counter
	#addi s2, s2, 10 # increment the record counter

	#mv s7, a0
	#crlf
	#crlf
	#print_Int(s2)
	#crlf
	#print_Int(s3)
	#crlf
	#crlf
	#mv a0, s7
	
	
	blt s2, s10, getIncome # compare counter with total number of records
	mv a0, s3
	
	lw, s1, 40(sp)
	lw, s2, 36(sp)
	lw, s3, 32(sp)
	lw, s4, 28(sp)
	lw, s5, 24(sp)
	lw, s6, 20(sp)
	lw, s7, 16(sp)
	lw, s8, 12(sp)
	lw, s9, 8(sp)
	lw, s10, 4(sp)
	lw, s11, 0(sp)
	addi sp, sp, 44
	
	ret
	
	
#getIncomeAddress: # get the starting address of the numerical income within a record
	
	#lbu a4, 0(a0) # load character at pointer location
	
#	jal nextChar
#	ret
	
#nextChar:
getIncomeAddress:
	lbu s9, 0(s11) # load character at pointer location
	addi s11, s11, 1 # increment pointer location by 1 byte
	addi s4, s4, 1 # increment the overall byte counter
	bne s9, s1, getIncomeAddress
	ret
	
	




	#li a0, 0
	#if no student code entered, a0 just returns 0 always :(
	
# End your  coding  here!
	
	ret
#######################end of nameOfMaxIncome_totalIncome###############################################
#.include "income_from_record.asm"
