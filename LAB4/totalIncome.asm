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
	

	# Start your coding from here!

	li t1, 44 # '\r', ASCII code of "comma" character

		
	#lwu a0, 0(a0) #Load the file record pointer array location
	mv s8, a0 #save the initial pointer location
	lwu s11, 0(a0) #Load the file record pointer array location
	mv s10, a1 #save a1, number of records in file
	li t2, 0 # initialize a record counter
	li t3, 0 # initialize the income total sum
	li t4, 0 # initialize a byte counter
	#lbu a4, 0(a0) # load the first character in file




#incomeSumLoop: # Maybe... the outer loop?
	blt t2, s10, getIncome 
	
	li a0, 0
	
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
	
	#sw s11, 4(s8)
	#addi a0, s8, 4
	
	addi sp, sp, -16
	sw, t1, 12(sp)
	sw, t2, 8(sp)
	sw, t3, 4(sp)
	sw, t4, 0(sp)
	
	addi sp, sp, -4
	sw, ra, 0(sp)
	jal income_from_record #income from record will be returned in a0, next character (not cr of lf) in a2
	lw, ra, 0(sp)
	addi sp, sp, 4

	lw, t1, 12(sp)
	lw, t2, 8(sp)
	lw, t3, 4(sp)
	lw, t4, 0(sp)
	addi sp, sp, 16
			
	addi sp, sp, 4 # need to pop "s11" off of the stack , right?
	
	add t3, t3, a0 # add to the running sum

	
	mv s11, a2 # shift record pointer to the next record title, using output from "income_from_record"
	addi t2, t2, 1 # increment the record counter

	blt t2, s10, getIncome # compare counter with total number of records
	mv a0, t3
	
	ret
	

getIncomeAddress:
	lbu s9, 0(s11) # load character at pointer location
	addi s11, s11, 1 # increment pointer location by 1 byte
	addi t4, t4, 1 # increment the overall byte counter
	bne s9, t1, getIncomeAddress
	ret
	
	




	#li a0, 0
	#if no student code entered, a0 just returns 0 always :(
	
# End your  coding  here!
	
	ret
#######################end of nameOfMaxIncome_totalIncome###############################################
#.include "income_from_record.asm"
