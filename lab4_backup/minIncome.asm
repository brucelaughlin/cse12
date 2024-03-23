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

	ret
#######################end of minIncome###############################################
