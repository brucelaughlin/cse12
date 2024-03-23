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
	
	#li a0, 0x1004000
	#li a0, 0xffff0000	

	addi a0, a0, 0x10

	ret
#######################end of maxIncome###############################################
