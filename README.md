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
    * just deal with 50% queries (for the 50% correctness);
    * move the whole distance computation into GPU.

