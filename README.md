# ICS3203-CAT2-Assembly-Nancy-Mungai-150912
## TASKS

 This repository contains four assembly programs including control flow, array manipulation, modular subroutines, and port-based simulation. 
 - Note I wrote the code for a 32-bit Linux environment and used int 0x80 for system calls.

## Task 1: Control Flow and Conditional Logic
## Brief Overview

This program classifies a users input number as POSITIVE, NEGATIVE, or ZERO using conditional and unconditional jump instructions.

## Instructions on compiling and running the code

- Assemble the program:

nasm -f elf32 controlFlow.asm -o controlFlow.o

- Link the object file:

ld -m elf_i386 controlFlow.o -o controlFlow

- Run the program:

./controlFlow

- Expected output

Input : 5, The number is Positive.

Input : -5,The number is Negative.

Input : 0, The number is Zero.


## Insights or challenges encountered in each task
- Used cmp and conditional jumps for classification.
- Integrated unconditional jumps to streamline program flow and avoid redundant comparisons.

- Challenge: Ensuring program flow was efficient and readable without excessive jumps.


## Task 2: Array Manipulation with Looping and Reversal
## Brief Overview
This program accepts an array of integers, reverses it in place, and outputs the reversed array using looping constructs.

## Instructions on compiling and running the code

- Assemble the program:

nasm -f elf32 array_reversal.asm -o array_reversal.o

- Link the object file:

ld -m elf_i386 array_reversal.o -o array_reversal


- Run the program:

./array_reversal

- Expected output

Input : 1 2 3 4 5

Reversed array: 5 4 3 2 1




## Insights or challenges encountered in each task

- Implemented an in-place reversal by swapping elements using mov and indexing.

- Challenges included:
Handling memory directly without overwriting data.

- Efficiently using registers to manipulate array indices.

## Task 3: Modular Program with Subroutines for Factorial Calculation
## Brief Overview
This program calculates the factorial of a number using a modular approach. A separate subroutine performs the calculation, showcasing stack usage for preserving registers.


## Instructions on compiling and running the code


- Assemble the program:

nasm -f elf32 factorial.asm -o factorial.o

- Link the object file:

ld -m elf_i386 factorial.o -o factorial
- Run the program:

./factorial
- Output Example 

Enter a number to find its factorial:   5

Factorial:  120

## Insights or challenges encountered in each task

- Used the stack to preserve and restore registers during the subroutine call.
- Challenges included:
Properly handling the return address during the subroutine.
Ensuring the calculation was accurate for all input values

## Task 4: Data Monitoring and Control Using Port-Based Simulation
## Brief Overview

This program simulates a control system that monitors a "sensor value" and takes appropriate actions such as:
- Turns the motor ON or OFF.
- Triggers an alarm if the water level is too high.

## Instructions on compiling and running the code.

- Assemble the program:

nasm -f elf32 simulation.asm -o simulation.o

- Link the object file:

ld -m elf_i386 simulation.o -o simulation
- Run the program:

./simulation

- Output Example


Input sensor value: 4
Motor OFF: Water level moderate  
Input sensor value: 8
ALARM ON: Water level high!
Input sensor value: 0
Motor OFF: Water level low

## Insights or challenges encountered in each task.

- Simulated memory-mapped IO for motor and alarm statuses.

- Challenges:
Balancing readability with logic efficiency.
Ensuring proper memory manipulation to reflect changes in motor and alarm states.


