# Author: Mayank Arya
# Roll No: 1301CS28
# Find min and maximum element in an array
.data
	# if size of array is not edited if array is edited then
	# answer may be wrong <CHANGE TAG> 
	array: .word 3,1,45,4,-17,9,34,65,-100,80,234,43,-4732,563,554,56
	outputMin: .asciiz "\nMinimum : "
	outputMax: .asciiz "Maximum : "
	min0: .asciiz "minimum"
	max0: .asciiz "maximum"
	nextLine: .asciiz "\n"

	help: .asciiz "<CHANGE TAG> in code helps you identifying where to change the size of array\nBy default there are 16 terms in array\n"
.text
main:
	li $v0,4
	la $a0,help
	syscall

	#loading address of array into $s0
	la $s0,array


	# number of terms in $t0 
	# ****** 16 here is number of terms please edit if you change 
	# the size of array ************
	#<CHANGE TAG>
	addi $t0,$t0,16

	#copying number of terms to $t1 from $t0
	move $t1,$t0
	

	# ACTIVATION RECORD OF MINMAX
	#	|					|
	#	|____MAXIMUM NO.____|
	#	|					|	
	#	|____MINIMUM NO.____|
	#	|					|	
	#	|__NO OF TERMS______|
	#	|					|
	#	|_____ELEMENTS______|
	#	|					|
	#	|________OF_________|
	#	|					|
	#	|______ARRAY________|
	
	#copying elements of array to stack
	loop:
		lw $s1,($s0)
		sw $s1,($sp)
		addi $sp,$sp,-4
		addi $s0,$s0,4
		addi $t0,$t0,-1
		bne $t0,$zero,loop

		#puhing numbers of terms in stack
		sw $t1,0($sp)

		#top space for returning minimum and maximum
		addi $sp,$sp,-8

	# calling minMax function
 	jal minMax

  	# print maximum output string

  	li $v0,4
  	la $a0,outputMax
  	syscall
  	# print maximum term
  	
  	#loading maximum from top of stack with byte offset 0
  	lw $s1,0($sp)
  	li $v0,1
  	move $a0,$s1
  	syscall

  	#print minimum output string
  	li $v0,4
  	la $a0,outputMin
  	syscall

  	#print minimum term
  	#lading minimum from the top of stack with byte offset 4
  	lw $s0,4($sp)
  	li $v0,1
  	move $a0,$s0
  	syscall

  	#exiting the program
  	li $v0,10
  	syscall

 	# $s0 contins the min $s1 contains the minimum
 minMax:
 		move $t8,$sp
 		addi $t8,$t8,8
 		#loading number of terms into $t0
 		lw $t0,0($t8)
 		addi $t8,$t8,4
 		lw $t1,0($t8)
 		move $s0,$t1
 		move $s1,$t1

		loop1:
			lw $t1,0($t8)

			bgt $t1,$s1,max
			back1:	

			blt $t1,$s0,min
			back2:	
				
			addi $t0,$t0,-1
			addi $t8,$t8,4
			bne $t0,$zero,loop1

			# add to top of stack min and max
			sw $s0,($t8)
			addi $t8,$t8,-4
			sw $s1,($t8)
			# return  	
			jr $ra		

max:
	sw $t1,0($sp)
	move $s1,$t1
	j back1
min: 
	sw $t1,4($sp)
	move $s0,$t1
	j back2



