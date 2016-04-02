.data
	chico: .word 1,4,5,7,8,5,4,6,34,85,66,8,345,253,54
	output: .asciiz "Sum of first 10 words is "

.text
main:

	la $a1,chico #loads the base address of chico in $a1
 	li $s1,10 #loads 10 in $s1 

 	 # ********to be updated if number of words in chico array is increased ******
	li $s2,15 # total number of words in chico array 
			

	move $s0,$zero #initialising sum=0 
	move $t1,$zero # count of number of terms

loop:
	 	lw $t0,0($a1)
	 	addi $t1,$t1,1
	 	bgt $t1,$s2,exit
	 	bgt $t1,$s1,escape # if number of terms >13 only first 10 are added
	 		add $s0,$s0,$t0
	 	escape:
	 		addi $a1,$a1,4
	 	j loop

exit:
	
	# prints the output line
	li $v0,4
	la $a0,output
	syscall

	#stores the sum at the end of array
	sw $s0,0($a1)

	#prints the sum of first 10 numbers
	li $v0,1
	move $a0,$s0
	syscall
