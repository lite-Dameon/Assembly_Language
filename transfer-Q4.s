.data
	dest: .word 0:10
	input: .asciiz "Enter the value of n \n"
	copied: .asciiz "Numbers Copied "
	comma: .asciiz ","
	src: .word 4,5,6,23,2,3,56,2,54,35,543,213
	
.text

main:

	li $v0,4
	la $a0,input
	syscall

	li $v0,5
	syscall #input number from user
	move $s0,$v0
	
	move $t0,$zero
	move $t1,$zero

	# $s0 and $s1 contain the base address of source and destination
	la $s1,src
	la $s2,dest

	#print the copied string
	li $v0,4
	la $a0,copied
	syscall

loop:
	bge $t0,$s0,exit 

	lw $t1,0($s1) # loading word from $s1 location to $t1
	sw $t1,0($s2) # saving word to $s2 location from $t1

	li $v0,1
	move $a0,$t1
	syscall # print the copied number

	li $v0,4
	la $a0,comma
	syscall  #print , after number

	addi $t0,$t0,1
	addi $s2,$s2,4 # accessing the address for next word
	addi $s1,$s1,4 # acessing the address of next word

	j loop

exit:
	li $v0,10
	syscall
