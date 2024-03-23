minIncome:
#finds the total income from the file
#arguments:	a0 contains the file record pointer array location (0x10040000 in our example) But your code MUST handle any address value
#		a1:the number of records in the file
#return value a0:the total income (add up all the record incomes)

	#if empty file, return 0 for both a0, a1
	bnez a1, minIncome_fileNotEmpty # minIncome function
	li a0, 0
	ret

 minIncome_fileNotEmpty:

#lwu a0, 0(a0) #Load the file record pointer array location
	mv t1, a0 #save the initial pointer location
	mv s11, a1 # save the total number of records
	
	#li t2, 99999999999999 # store the current high income (integer)
	li t3, 0 # record (loop) counter
	mv t4, a0 # pointer to high income company name		
	
	mv t5, a0 # incrementing pointer to company names
	addi t6, t5, 4 # incrementing pointer to company income

	addi sp, sp, -24
	sw t1, 20(sp)
	sw t2, 16(sp)
	sw t3, 12(sp)
	sw t4, 8(sp)
	sw t5, 4(sp)
	sw t6, 0(sp)

	addi sp, sp, -4
	sw, ra, 0(sp)
	jal income_from_record #income from record will be returned in a0, next character (not cr of lf) in a2
	lw, ra, 0(sp)
	addi sp, sp, 4
	
	lw t1, 20(sp)
	lw t2, 16(sp)
	lw t3, 12(sp)
	lw t4, 8(sp)
	lw t5, 4(sp)
	lw t6, 0(sp)
	addi sp, sp, 24
	
	
	mv t2, a0


	blt t3, s11, getIncome3 
	# never executes (file not empty)
	mv a0, t1
	ret

getIncome3:   # get the income for the current record, input as a_
		
	#addi t3, t3, 1 # increment loop counter
	bgtz t3, incrementPointers2
	
continueLoop2:
	
	mv a0, t6 # prepare input to "income from record"
	
	addi sp, sp, -24
	sw t1, 20(sp)
	sw t2, 16(sp)
	sw t3, 12(sp)
	sw t4, 8(sp)
	sw t5, 4(sp)
	sw t6, 0(sp)

	addi sp, sp, -4
	sw, ra, 0(sp)
	jal income_from_record #income from record will be returned in a0, next character (not cr of lf) in a2
	lw, ra, 0(sp)
	addi sp, sp, 4
	
	lw t1, 20(sp)
	lw t2, 16(sp)
	lw t3, 12(sp)
	lw t4, 8(sp)
	lw t5, 4(sp)
	lw t6, 0(sp)
	addi sp, sp, 24
	
	addi sp, sp, -4
	sw, ra, 0(sp)	
	jal compareIncome2	
	lw, ra, 0(sp)
	addi sp, sp, 4
	
	addi t3, t3, 1 # increment loop counter
	#ble t3, s11, getIncome2 # compare counter with total number of records
	
	blt t3, s11, getIncome3 # compare counter with total number of records
			
	mv a0, t4
	#mv a0, t1
	
	ret

	
compareIncome2:

	blt a0, t2, assignMinIncome

	ret
	
assignMinIncome:
	
	mv t2, a0
	mv t4, t5
	ret
	

incrementPointers2:

	addi t5, t5, 0x08
	addi t6, t6, 0x08		

	j continueLoop2
				




	ret
#######################end of minIncome###############################################
