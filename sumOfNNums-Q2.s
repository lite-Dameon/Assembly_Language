.data
	input: .asciiz "Enter  the value of n \n"
	output1: .asciiz "Sum of first "
	output2: .asciiz " numbers is "

.text
main:

	li $v0,4
	la $a0,input
	syscall # print the input line

	li $v0,5
	syscall # takes a number as input

	move $s0,$v0 # $s0 = $v0
	
	addi $s2,$s2,1 #increasing value of n

	addi $t0,$zero,1 #set initial value in $t0 to 1
	
	move $s1,$zero # $s1 for sum of first n numbers 

loop:
	bgt $t0,$s0,exit
	add $s1,$s1,$t0 #sum = sum +$t0
	addi $t0,$t0,1  # $t0++
	j loop
exit:
	li $v0,4
	la $a0,output1
	syscall # print the input line

	li $v0,1
	move $a0,$s0
	syscall # print the n 

	li $v0,4
	la $a0,output2
	syscall # print the input line

	li $v0,1
	move $a0,$s1
	syscall # print the sum of first n integers



