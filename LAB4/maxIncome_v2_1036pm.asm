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

	# New approach, use the table of pointers
		
				
	#lwu a0, 0(a0) #Load the file record pointer array location
	mv t1, a0 #save the initial pointer location
	mv s11, a1 # save the total number of records
	
	li t2, 0 # store the current high income (integer)
	li t3, 0 # record (loop) counter
	mv t4, a0 # pointer to high income company name		
	
	mv t5, a0 # incrementing pointer to company names
	addi t6, t5, 4 # incrementing pointer to company income
		
	blt t2, s11, getIncome2 

	# never executes (file not empty)
	mv a0, t1
	

	ret

getIncome2:   # get the income for the current record, input as a_
	
	#addi t3, t3, 1 # increment loop counter
	bgtz t3, incrementPointers1
	
continueLoop1:
	
	mv a0, t6 # prepare input to "income from record"
	
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
	
	addi t3, t3, 1 # increment loop counter
	ble t3, s11, getIncome2 # compare counter with total number of records
		
	mv a0, t4
	
	ret

	
compareIncome:

	bgt a0, t2, assignMaxIncome

	ret
	
assignMaxIncome:
	
	mv t2, a0
	mv t4, t5
	
#	crlf
#	crlf
#	print_int_hex(t4)
#	crlf
#	crlf	

incrementPointers1:

	addi t5, t5, 0x8
	addi t6, t6, 0x8		
	


	#addi t5, t5, 8
	#addi t6, t6, 8	
	j continueLoop1
				
				
				
				
#	ret
	


	#ret
#######################end of maxIncome###############################################
