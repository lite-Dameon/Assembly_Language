# Author: Mayank Arya
# Roll No: 1301CS28
# Sort an array of numbers using mergesort

.data
	andl : .asciiz " and "
	nextLine: .asciiz " \n"
	n1: .asciiz "n==1 "
	returning: .asciiz "going \n"

	#****** UNSORTED ARRAY ******
	# <CHANGE TAG> : IF YOU CHANGE ARRAY CHANGE THE ARRAY SIZE ALSO and SPACE ALLOCATED TO SOLUTION 4*no. of elements
	array: .word 6,32,1,5,83,2,54,12,34,43,45,65,675,23,32,122,45
	#<CHANGE TAG>
	sorted: .space 68 #4* number of terms
	
	completed: .asciiz "Sorted Array : "
	storing: .asciiz "storing $t9 "
	check1: .asciiz "Checking 1\n"
	check2: .asciiz "Checking 2\n"
	check3: .asciiz "Checking 3\n"
	comma: .asciiz ","

	unsorted: .asciiz "Unsorted Array : "
	help: .asciiz "<CHANGE TAG> in code helps you identifying where to change the size of array\nBy default 17 terms are in array\n"
.text
main:

	
	li $v0,4
	la $a0,help
	syscall

	#addi $t9,$t9,8
	
	#<CHANGE TAG
	# number of terms in $s0 
	# ****** 17 here is number of terms please edit if you change 
	# the array ************
	addi $s0,$s0,17 #number of elements

	la $s1,sorted
	# moving $s1 to $s5 for printing use of array
	move $s5,$s1
	la $s2,array

	li $v0,4
	la $a0,unsorted
	syscall


	#<CHANGE TAG>
	# ****** 17 here is number of terms please edit if you change 
	# the array ************
	move $a1,$zero
	addi $a1,$a1,17
	move $a2,$s2
	# call to print unsorted array
	jal printArray 

	move $t4,$s1
	move $t5,$s2
	move $t0,$zero
	addi $t8,$t8,1

	# creating first activation record
	sw $s0,-4($sp)
	sw $t4,-8($sp)
	sw $t5,-12($sp)
	addi $sp,$sp,-184

	jal sort

	runout:
		li $v0,4
		la $a0,nextLine
		syscall

		li $v0,4
		la $a0,completed
		syscall

	#<CHANGE TAG>
	# number of terms in $s0 
	# ****** 17 here is number of terms please edit if you change 
	# the array ************
		move $a1,$zero
		addi $a1,$a1,17
		move $a2,$s5
		# call to print Sorted Array
		jal printArray

		li $v0,10
		syscall


	# ACTIVATION RECORD OF Merge sort
	#	_____________________
	#	|					|	
	#	|       A1          |
	#	|					|	
	#	|___________________|
	#	|					|
	#	|      A2           |
	#	|					|
	#	|___________________|
	#	|		n2			|
	#	|___________________|
	#	|		n1			|	
	#	|___________________|
	#	| return  address	|	
	#	|___________________|
	#	|		A			|
	#	|___________________|
	#	|		B			|
	#	|___________________|
	#	|		N			|
	#	|___________________|		

sort:
	sw $ra,168($sp)
	lw $t0,180($sp)

	# if n==0 goto runnout
	beq $t0,$zero,runout

	bne $t0,$t8,else1



		lw $t7,172($sp)
		lw $t9,0($t7)


		lw $t7,176($sp)
		sw $t9,0($t7)
		j jump1

	else1:
		#calculate n1 and n2
		div $t2,$t0,2 #n1
		sub $t3,$t0,$t2#n2
		sw $t2,160($sp)
		sw $t3,164($sp)
	

		#moving data for first sort call
		lw $s0,160($sp) # n1
		addi $s1,$sp,0 #A1
		lw $s2,172($sp)	 #A


		#first sort call Sort(A,A1,n1)
		sw $s0,-4($sp)
		sw $s1,-8($sp)
		sw $s2,-12($sp)
		addi $sp,$sp,-184

		jal sort

		#moving data for second sort call
		lw $s0,164($sp) #n2
		addi $s1,$sp,80 #A2
		lw $s7,160($sp) #loading n1
		mul $t5,$s7,4
		lw $s2,172($sp)
		add $s2,$s2,$t5 #A+n1
		#second call to sort SOrt(A+n1,A2,n2)
		sw $s0,-4($sp) 
		sw $s1,-8($sp)
		sw $s2,-12($sp) 
		addi $sp,$sp,-184
		jal sort


		#creating activation record of merge
		lw $t1,160($sp) #laoding n1
		sw $t1,-8($sp) #storing p 
		lw $t1,164($sp) #loading n2
		sw $t1,-4($sp) #storing q
		

		addi $a3,$sp,0 #array of length q
		addi $a1,$sp,80 #array of length p
		lw $a2,176($sp) #place where sorted array to be stored
		addi $sp,$sp,-12
		jal merge

	jump1:	
		
		lw $ra,168($sp)
		addi $sp,$sp,184
		jr $ra

#*********** MERGE FUNCTION ********#

	# ACTIVATION RECORD OF merge
	#	_____________________
	#	|	return address	|
	#	|___________________|
	#	|		p			|
	#	|___________________|
	#	|		q			|
	#	|___________________|


merge:
	sw $ra,($sp) 

	lw $s1,4($sp) # p(n1)
	lw $s2,8($sp) # q(n2)

	move $t0,$zero # int i=0
	move $t1,$zero # int j=0
	move $t2,$zero # int k=0	

	L0:
		bge $t0,$s1,exit0 # while(i<p )
		bge $t1,$s2,exit0 #	while(j<q)

			mul $t3,$t0,4 #multiply i by 4
			add $t3,$t3,$a3 #add base address of P
			mul $t4,$t1,4 #multiply j by 4
			add $t4,$t4,$a1 #add base address of Q
			lw $t5,($t3) # load P[i]
			#lw $t5,($t5) #modified
			lw $t6,($t4) # load Q[j]
			#lw $t6,($t6) #modified
			mul $t7,$t2,4 #multiply i by 4
			add $t7,$t7,$a2 #add base address of R

			bge $t5,$t6,else0
				sw $t5,($t7)   #R[k]=P[i]
				addi $t0,$t0,1 #i++
				j jump
			else0:
				sw $t6,($t7) #R[k]=Q[j]
				addi $t1,$t1,1 # j++

			jump:
				add $t2,$t2,1 # k++
				j L0

	exit0:

	L1:
		bge $t0,$s1,exit1

			# copying remaining elements of P
			mul $t3,$t0,4
			add $t3,$t3,$a3
			mul $t7,$t2,4
			add $t7,$t7,$a2
			lw $t5,($t3)
			sw $t5,($t7)
			addi $t0,$t0,1
			addi $t2,$t2,1
		j L1
		
	exit1:

	L2:
		bge $t1,$s2,exit2

			# copying remaining elements of Q
			mul $t4,$t1,4
			add $t4,$t4,$a1
			mul $t7,$t2,4
			add $t7,$t7,$a2
			lw $t6,($t4)
			sw $t6,($t7)
			addi $t1,$t1,1
			addi $t2,$t2,1
		j L2

	exit2:
	lw $ra,($sp)
	addi $sp,$sp,12
	jr $ra


# method to print an array 
printArray:
	move $t0,$zero
	# $a1 contains the number of terms and $a2 contains the base address

L3:	beq $t0,$a1,exit3

		lw $t1,($a2)
		addi $a2,$a2,4
		li $v0,1
		move $a0,$t1
		syscall

		li $v0,4
		la $a0,comma
		syscall

		addi $t0,$t0,1
		j L3
	exit3:
		jr $ra
