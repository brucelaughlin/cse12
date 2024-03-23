maxIncome:
#finds the total income from the file
#arguments:	a0 contains the file record pointer array location (0x10040000 in our example) But your code MUST handle any address value
#		a1:the number of records in the file
#return value a0: heap memory pointer to actual  location of the record stock name in the file buffer


#t1-4 used in main, so swap those out


	#if empty file, return 0 for both a0, a1
	bnez a1, maxIncome_fileNotEmpty # maxIncome Function
	li a0, 0
	ret
	

 maxIncome_fileNotEmpty:
	
	# Start your coding from here!

	#li a0, 0x10040010
	#if no student code entered, a0 just returns 0x10040010 always :(	
	
	li t1, 44 # '\r', ASCII code of "comma" character

	#lwu a0, 0(a0) #Load the file record pointer array location
	mv s8, a0 #save the initial pointer location
	lwu s11, 0(a0) #Load the file record pointer array location
	mv s10, a1 #save a1, number of records in file
	li t2, 0 # initialize a record counter
	li t3, 0 # initialize the minimum income, starting at 0
	li t4, 0 # initialize a byte counter
	mv s6, s11 # initialize the "heap memory pointer to actual  location of the record stock name in the file buffer"
	mv s7, s11 # store the original
	
	mv t6, a0
	
	# Determine a "safe???" location on the heap to store the new pointer
	li t5, 8 # each part of the heap is a word, but each record has a name and an income, so there are 2 words per company = 8 bytes
	mul t5, t5, a1
	#addi t5, t5, 4
	add t5, t5, a0
	#addi t5, t5, 4
		
#	#mv s7, a0
#	crlf
#	crlf
#	print_int_hex(s8)
#	crlf
#	print_int_hex(t5)
#	crlf
#	crlf
#	#mv a0, s7
		
	blt t2, s10, getIncome2 

	# never executes (file not empty)
	mv a0, s8
	

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
	
	#sw s11, 4(s8)
	#addi a0, s8, 4
	
	
	addi sp, sp, -4
	sw, ra, 0(sp)
	
	addi sp, sp, -16
	sw, t1, 12(sp)
	sw, t2, 8(sp)
	sw, t3, 4(sp)
	sw, t4, 0(sp)
	
	jal income_from_record #income from record will be returned in a0, next character (not cr of lf) in a2
	
	lw, t1, 12(sp)
	lw, t2, 8(sp)
	lw, t3, 4(sp)
	lw, t4, 0(sp)
	addi sp, sp, 16
	
	lw, ra, 0(sp)
	addi sp, sp, 4
	
	addi sp, sp, 4 # need to pop "s11" off of the stack , right?
	
	addi sp, sp, -4
	sw, ra, 0(sp)
		
	jal compareIncome
		
	lw, ra, 0(sp)
	addi sp, sp, 4
	
	mv s11, a2 # shift record pointer to the next record title, using output from "income_from_record"
	addi t2, t2, 1 # increment the record counter
	
	
	blt t2, s10, getIncome2 # compare counter with total number of records
	
	#mv a1, s6
	#mv a2, s8			
	
	# testing
	

	
	
	#addi sp, sp, -4 #Need to store address pointer points to in a new address, for "income_from_record" to load
	#sw a1, 0(sp)
	#mv a0, sp	
	
	#sw a1, 4(s8)
	#addi a0, s8, 4
	
	#sw a1, 0(t5)
	
	#sw s6, 0(t5)
	#mv a0, t5
	
	#sw s6, 0(t6)
	#mv a0, t6
	
	# THIS ONE SHOULD WORK???
	#sw t6, 0(t5)
	#mv a0, t5
	
	
#	crlf
#	crlf
#	print_Int(t6)
#	crlf
#	crlf	
	
	mv a0, s8
	#addi a0, a0, 8
	add a0, a0, t6
	
	#addi sp, sp, -4 #Need to store address pointer points to in a new address, for "income_from_record" to load
	#sw t6, 0(sp)
	#mv a0, sp
	
	
	#testing
	#lwu a5, 0(s8)
	#lwu a6, 0(a0)
	#lbu a5, 0(a5) # load character at pointer location
	#lbu a6, 0(a6) # load character at pointer location
	
#	mv a3, a0
#	crlf
#	crlf
#	print_int_hex(s7)
#	crlf
#	print_int_hex(t6)
#	#print_int_hex(a5)
#	#crlf
#	#print_int_hex(a6)
#	#print_character(a5)
#	#crlf
#	#print_character(a6)	
#	crlf
#	crlf
#	mv a0, a3
	
	#mv a0, s8
	
	ret

	
compareIncome:
	bgt a0, t3, assignMaxIncome
	
	#addi t6, t6, 8
	
	ret
	
assignMaxIncome:
	
	li s9, 8
	mul s9, s9, t2
	#add t6, s8, s9
	
	mv t6, s9

	crlf
	crlf
	print_Int(t6)
	crlf	
			
	#addi t6, t6, 8

	mv t3, a0
	mv s6, s5

#	#mv a3, a0
#	crlf
#	crlf
#	print_int_hex(s8)
#	crlf
#	print_Int(s8)
#	crlf
#	print_int_hex(s9)
#	crlf
#	print_Int(s9)
#	crlf
#	crlf
#	#mv a0, a3	
		
				
	ret
	
	
getIncomeAddress2:
	lbu s9, 0(s11) # load character at pointer location
	addi s11, s11, 1 # increment pointer location by 1 byte
	addi t4, t4, 1 # increment the overall byte counter
	bne s9, t1, getIncomeAddress2
	ret	
	
	

	#ret
#######################end of maxIncome###############################################
