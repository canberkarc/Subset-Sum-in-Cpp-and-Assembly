.data
	
	arr:	.space 400
	
	askArrSizeMessage: .asciiz "Size of Array : "
	askNumberMessage:  .asciiz "number : "
	askArrElementMessage: .asciiz " index element : "
	possibleMessage: .asciiz "Possible!\n"
	notPossibleMessage: .asciiz "Not possible!\n"
	
	space: .asciiz " "
	newline: .asciiz "\n"
	
	arraySize: .word 0
	num: .word 0
	returnVal: .word 0
	

.text 
	.globl main

main:
	
	li $v0, 4
	la $a0,askArrSizeMessage
	syscall

	#cin >> arraySize;
	li $v0, 5
	syscall
	sw $v0,	arraySize
	
	li $v0, 4
	la $a0,askNumberMessage
	syscall
	
	#cin >> num;
	li $v0, 5
	syscall
	sw $v0,	num
		
	
	#for(int i =0; i < arraySize; ++i)
	addi $t0,$zero,0 # int i =0;
	

forLoopForGetArray:
	lw $t5,arraySize
	bge $t0 $t5 outOfForLoopForGetArray #i < arraySize;
	
	li $v0, 1
	move $a0,$t0
	syscall
	
	li $v0, 4
	la $a0,askArrElementMessage
	syscall
	
	#cin >> arr[i];
	li $v0, 5
	syscall
	move $t1, $v0
	
	mul $t2, $t0, 4
	sw $t1, arr($t2)

	addi $t0,$t0,1	#++i
	j forLoopForGetArray
	
outOfForLoopForGetArray:	
		
	
	#returnVal = CheckSumPossibility(num, arr,arraySize);
	lw $a0,num
	addi $a1,$zero,0
	lw $a2,arraySize
	jal CheckSumPossibility	
	sw $v0,	returnVal
	
	
	lw $t1, returnVal
	
	#if(returnVal ==1)
	beq $t1, 1, printPossibleMessage
	
	#else
	#cout <<"Not possible!"<<endl;
	li $v0, 4
	la $a0,newline
	syscall
	
	li $v0, 4
	la $a0,notPossibleMessage
	syscall
	
	
finished:	
		
	#return 0; 
	li $v0, 10
	syscall	


printPossibleMessage:
	#cout <<"Possible!"<<endl;
	li $v0, 4
	la $a0,newline
	syscall
	
	li $v0, 4
	la $a0,possibleMessage
	syscall
	
	j finished


#CheckSumPossibility function	
.globl CheckSumPossibility

CheckSumPossibility:
	subu $sp, $sp, 20
	sw $ra, ($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	
	add $s0, $a0,$zero
	add $s1, $a1,$zero
	add $s2, $a2,$zero	
	
	#if(num==0)
	li $v0, 1	#return 1;
	beq $s0, 0, CheckSumPossibilityFinished
	
	#else if (num<0)
	li $v0, 0	#return 0;
	blt $s0, 0, CheckSumPossibilityFinished
	
	#if(arraySize==0)
	li $v0, 0	#return 0;
	beq $s2, 0, CheckSumPossibilityFinished
	

	#int addToSum=CheckSumPossibility(num-arr[0], arr+1,arraySize-1);
	lw $t3, arr($s1)
	
	sub $a0, $s0, $t3
	addi $a1, $s1, 4
	sub $a2, $s2, 1
	jal CheckSumPossibility
	
	add $s3, $v0, $zero
	move $t4,$v0
	

	move $t5,$zero
	
	bne $s3, 1, notPrint
	
	lw $t3, arr($s1)
	li $v0, 1
	move $a0,$t3
	syscall
	
	li $v0, 4
	la $a0,space
	syscall
	#if(addToSum!=1)
	j outOfCheckSumPossibilityCall
notPrint:

	#notAddToSum=CheckSumPossibility(num, arr+1,arraySize-1);
	add $a0, $s0, $zero
	add $a1, $s1, 4
	sub $a2, $s2, 1
	jal CheckSumPossibility
	
	move $t5,$v0

outOfCheckSumPossibilityCall:	
	
	#return addToSum || notAddToSum;
	beq $t5, 1, CheckSumPossibilityReturnOne
	
	beq $s3, 1, CheckSumPossibilityReturnOne
	
	li $v0, 0
CheckSumPossibilityReturnOneFinished:	
CheckSumPossibilityFinished:
	lw $ra, ($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	addu $sp, $sp, 20
	jr $ra
	
CheckSumPossibilityReturnOne:
	li $v0, 1
	j CheckSumPossibilityReturnOneFinished