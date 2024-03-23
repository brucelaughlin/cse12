maxIncome:
#finds the total income from the file
#arguments:	a0 contains the file record pointer array location (0x10040000 in our example) But your code MUST handle any address value
#		a1:the number of records in the file
#return value a0: heap memory pointer to actual  location of the record stock name in the file buffer

	#if empty file, return 0 for both a0, a1
	bnez a1, maxIncome_fileNotEmpty # maxIncome Function
	li a0, 0
	ret

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



 maxIncome_fileNotEmpty:
	
	# Start your coding from here!

	#li a0, 0x10040010
	#if no student code entered, a0 just returns 0x10040010 always :(
	
# End your  coding  here!
	
	
	li s1, 44 # '\r', ASCII code of "comma" character
	#addi s1, s1, -48  # subtract 48 from the '\r' ascii code, to compare with numbers
	#add s1, s1, s4  # subtract 48 from the ',' ascii code, to compare with numbers
		
	#lwu a0, 0(a0) #Load the file record pointer array location
	mv s8, a0 #save the initial pointer location
	lwu s11, 0(a0) #Load the file record pointer array location
	mv s10, a1 #save a1, number of records in file
	li s2, 0 # initialize a record counter
	li s3, 0 # initialize the minimum income, starting at 0
	li s4, 0 # initialize a byte counter
	mv s6, s11 # initialize the "heap memory pointer to actual  location of the record stock name in the file buffer"
	
	
	
	blt s2, s10, getIncome2 
	addi sp, sp, -4 #Need to store address pointer points to in a new address, for "income_from_record" to load
	sw s6, 0(sp)
	mv a0, sp
	addi sp, sp, 4
	#mv a0, s6
	
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

getIncome2:   # get the income for the current record, input as a_
	
	mv s5, s11 # TEMPORARY "heap memory pointer to actual  location of the record stock name in the file buffer"
	
	addi sp, sp, -4
	sw, ra, 0(sp)
	jal getIncomeAddress2
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
	
	addi sp, sp, -4
	sw, ra, 0(sp)
	jal compareIncome
	lw, ra, 0(sp)
	addi sp, sp, 4
	
#	mv s7, a0
#	crlf
#	crlf
#	print_Int(s2)
#	crlf
#	print_Int(s7)
#	crlf
#	print_Int(s3)
#	crlf
#	crlf
#	mv a0, s7
	
	mv s11, a2 # shift record pointer to the next record title, using output from "income_from_record"
	addi s2, s2, 1 # increment the record counter
	
	
	blt s2, s10, getIncome2 # compare counter with total number of records
	addi sp, sp, -4 #Need to store address pointer points to in a new address, for "income_from_record" to load
	sw s6, 0(sp)
	mv a0, sp
	#mv a0, s6
	
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

	
compareIncome:
	bgt a0, s3, assignMaxIncome
	ret
	
assignMaxIncome:
	mv s3, a0
	mv s6, s5
	ret
	
	
getIncomeAddress2:
	lbu s9, 0(s11) # load character at pointer location
	addi s11, s11, 1 # increment pointer location by 1 byte
	addi s4, s4, 1 # increment the overall byte counter
	bne s9, s1, getIncomeAddress2
	ret	
	
	
	
	
	
	
	
	
	
	
	
	#ret
#######################end of maxIncome###############################################
