.text

	li t0, 13 # '\r', ASCII code of "carriage return" character
	
	addi t0, t0, -48  # subtract 48 from the '\r' ascii code, to compare with numbers
	
	li t1, 10 # multiplication factor, to use later
	
	li t2, 49 # load the first character in file
	addi t2, t2, -48 # 0 is 48 in ASCII, so subtract 48 to get an int 0-9
	
	#bne t2, t0 incomeLoop #check that character is not a comma (which would indicate the end of the income data)

	li a7, 1  # print_Int macro
	#addi a0, t2, 0
	#ecall
	#addi a0, t0, 0
	#ecall
	
	li a7, 1
	li a0, 3
	ecall
	li a7, 11
	li a0, 13
	ecall
	li a7, 1
	li a0, 2
	ecall
	li a7, 11
	li a0, 10
	ecall
	li a7, 1
	li a0, 1
	ecall
	

	
	
	
#incomeLoop:

