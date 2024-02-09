# RIT-CISC830-Cyberinfrastructure-Foundation-Assignments

Solutions of assignments for the course CISC-830 Cyberinfrastructure Foundations

# Contents

* Assignment 1: Integer sorting
  * Faster solution: 10^6 numbers a thread using `std::sort`, then merge all the threads. $O(\log n * \log n)$ time complexity.
  * The complexity of counting sort under multiple threads is limited by the `max()` and `write(index++)` process.

