# RIT-CISC830-Cyberinfrastructure-Foundation-Assignments

Solutions of assignments for the course CISC-830 Cyberinfrastructure Foundations.

# Contents

* Assignment 1: Integer sorting
  * Passes all test cases in the time limit.
  * Faster solution: $10^6$ numbers a thread using `std::sort`, then merge all the threads. $O(\log n * \log n)$ time complexity.
  * The complexity of counting sort under multiple threads is limited by the `max()` and `write(index++)` process.

* Assignment 2: Nearest neighbor on DAG
  * Passes the first 8 test cases in the time limit.
  * This assignment has a *strict timeout limitation*, there are two large test cases easily to be timeout.
  * For less running time, you need:
    * combine all the queries in one matrix;
    * and move the whole distance computation into GPU.    

* Assignment 3: Tensor Library
  * Passes all test cases in the time limit.
  * Faster solution: for a sequence of operation of each tensor in the python script, maintain the last result in CUDA memory (no `cudafree()`), e.g. using a pair of "old-new" variables.

* Assignment 4: Discrete Logarithm
  * Passes all test cases in the time limit.
  * Faster solution: CPU BSGS using unordered container.
