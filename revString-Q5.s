.data
	input: .asciiz "Enter String \n"
	revrese: .asciiz "Revresed String : "	        
	str: .space 20

.text
	main:

		li $v0,4
		la $a0,input
		syscall

		jal readStr

		move $a0,$v0
		move $a1,$a0
		move $s1,$a0 # making copy of the first char address used in reversing
		move $t2,$zero

		

	#counting length of string or pointing the $a1 to end of string	
	loop:
		lb $t1,0($a1)	
		beq $t1,$zero,exit
		addi $t2,$t2,1
		addi $a1,$a1,1
		j loop	
		
	exit:
		#printing  reverse string
		#printing the output line
		li $v0,4
		la $a0,revrese
		syscall

		# $s3 contains '\0'
		move $s3,$t0 
		addi $a1,$a1,-2 #now #t0points to the last char of the string
		move $t5,$zero # for counting the reverse length

	#reversing the string
		loop2: 
			lb $t1,0($a1)# loading char into form $t0
			# storing bit at $t7
			sb $t7,0($a1)
			beq $a1,$s1,exit2
			# print the char
			li $v0,11
			move $a0,$t1
			syscall
			addi $t7,$t7,1
			#decreasing the $t0 address
			addi $t5,$t5,1
			addi $a1,$a1,-1
			j loop2

		exit2:
			li $v0,11
			move $a0,$t1
			syscall
			
		li $v0,10
		syscall #exit

	readStr:
			li $v0,8
			la $a0,str
			syscall # take input from user
			move $v0,$a0
			jr $ra
			