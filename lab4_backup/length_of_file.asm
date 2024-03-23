length_of_file:
#function to find length of data read from file
#arguments: a1=bufferAdress holding file data
#return file length in a0
	
	#Start your coding here

	li a0, 0
#if no student code provided, this function just returns 0 in a0

#.include "macros_rev2.asm"

#.text

	#li t0, 0 # '/0' "null" character; ASCII code 
     
     	#li a0, 0 # variable for length of file, starts at 0
	
	#addi t1, zero, a1 # variable for location in buffer
	
	#lbu t2, 0(t1) # load the first character in file
	lbu t2, 0(a1) # load the first character in file
	
	#if file is empty(the very first byte is 0) just do nothing and return
	bnez t2, bufferNotEmpty
        ret
        
bufferNotEmpty:
	addi a0, a0, 1 # Add 1 to length of file variable
	#addi t1, t1, 4 # Increment buffer location variable by one word (4 bytes) ...?
	addi a1, a1, 1 # Increment buffer location variable by one...byte... not word (not 4 bytes...)
	lbu t2, 0(a1) # load character at current buffer location (a1)
	bnez t2, bufferNotEmpty
        

#End your coding here
	
	ret
#######################end of length_of_file###############################################	
