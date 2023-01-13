# Assembly - 9 Exercises to learn more about the language
Each exercise teach some new technique...

## Exercise 1:
Your goal here is to simply load the processor registers A, X, and Y with some values.

## Exercise 2:
Your goal here is to just store some values into zero-page memory positions.

## Exercise 3:
This exercise is about transferring values from registers to other registers.

## Exercise 4:
This exercise is about adding and subtracting values. Adding and subtracting are math
operations that are done by the processor ALU (arithmetic-logic-unit). Since the ALU
can only manipulate values from the (A)ccumulator, all these additions and subtractions
must be performed with the values in the A register.

## Exercise 5:
The ADC and SBC instructions can also be used with different addressing modes. The
above exercise used ADC with immediate mode (adding a literal value directly into the
accumulator), but we can also ask ADC to add a value from a (zero page) memory
position into the accumulator.

## Exercise 6:
This exercise covers the increment and decrement instructions of the 6502.

## Exercise 7:
This exercise covers the increment and decrement using zero-page addressing mode.
The zero-page addressing mode helps us directly increment and decrement values
inside memory positions. The “zero page” in the 6502 are addresses between 0 and 255.
These addresses are special for the 6502 processor because we can store them using
only 1 byte (8 bits), which also means they can be performed relatively fast by the CPU.

## Exercise 8:
Your goal here is to create a loop that counts down from 10 to 0. You should also fill the
memory addresses from $80 to $8A with values from 0 to A.

## Exercise 9:
Your goal in this exercise is to create a simple loop that goes from 1 to 10. If possible, try
using the CMP instruction. This instruction that can be used to compare the value of
the accumulator with a certain literal number. Once the comparison is done, the
processor flags will be set (zero if the compared values are equal, non-zero if different).
