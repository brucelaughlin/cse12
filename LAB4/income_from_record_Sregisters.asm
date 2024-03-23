income_from_record:
#function to return numerical income from a specific record
#e.g. for record "Microsoft,34\r\n", income to return is 34(for which name is Microsoft)

#arguments:	a0 contains pointer to start of numerical income in record 

#function RETURNS income numerical value of the asci income in a0 (34 in our example)
	
# Start your coding from here!

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


	#li a0, 0 # income_from_record function
	#if no student code entered, a0 just returns 0 always :(
	
	#addi t5, a0, 0
	
	
	#mv s7, a0
	#crlf
	#crlf
	#print_Int(s7)
	#crlf
	#print_int_hex(s7)
	#crlf
	#crlf
	#mv a0, s7
	
	
	li t0, 13 # '\r', ASCII code of "carriage return" character
	addi t0, t0, -48  # subtract 48 from the '\r' ascii code, to compare with numbers
	li t1, 10 # multiplication factor, to use later
	
	lwu a0, 0(a0)
	addi t5, a0, 0
	
	#mv s7, a0
	#crlf
	#crlf
	#print_Int(s7)
	#crlf
	#print_int_hex(s7)
	#crlf
	#crlf
	#mv a0, s7
	
	
	lbu t2, 0(a0) # load the first character in file
	addi t2, t2, -48 # 0 is 48 in ASCII, so subtract 48 to get an int 0-9
	bne t2, t0, incomeLoop #check that character is not a comma (which would indicate the end of the income data)
	#bge t2, zero, incomeLoop
	li a0, 0
	addi a2, a0, 2 # return pointer location in a2 (add 2 to get to next title character, if exists (jump cr and nl))
	
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
	
incomeLoop:

	addi a0, a0, 1 # increment pointer location by 1 byte
	addi t6, a0, 0
	lbu t3, 0(a0) # load the next character in file
	addi t3, t3, -48
	bne t3, t0, mulLoop
	#bge t3, zero, mulLoop
	addi a2, a0, 2 # return pointer location in a2 (add 2 to get to next title character, if exists (jump cr and nl))
	addi a0, t2, 0
	
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
	
mulLoop:

	mul t2, t2, t1
	add t2, t2, t3
	j incomeLoop
	

	
# End your  coding  here!
	ret
	
#######################end of income_from_record###############################################	
