# Cache Simulator

A cache simulator for a college assignment.

## Results

The assignment involved investigating what effects a cache's configuration has
on its performance. The options being altered are:

- The number of sets (N)
- The number of lines in each set (K)
- The replacement policy

The number of bytes in each line (L) was kept constant.

### Replacement Policies

The replacement policies I impemented were:

- [LRU](https://en.wikipedia.org/wiki/Cache_algorithms#LRU)
- Pseudo LRU
  - Two different implementations [explained here](https://en.wikipedia.org/wiki/Pseudo-LRU)
- Random
  - Choose a random line to replace
- Improved Random
  - Fill the set and then start picking randomly

The results below show the hit rates of several configurations while accessing the addresses in `support/addresses.txt`.
As direct mapped caches essentially have no replacement policy all policies yield the same result in a direct mapped cache (30.3% hit rate).

### 4 sets 2 lines per set

| Replacement Policy | Hit Rate |
|--------------------|----------|
| LRU                | 0.424    |
| Pseudo LRU (tree)  | 0.424    |
| Pseudo LRU (bits)  | 0.394    |
| Random             | 0.364    |
| Improved Random    | 0.485    |

### 2 sets 4 lines per set

| Replacement Policy | Hit Rate |
|--------------------|----------|
| LRU                | 0.485    |
| Pseudo LRU (tree)  | 0.455    |
| Pseudo LRU (bits)  | 0.364    |
| Random             | 0.364    |
| Improved Random    | 0.394    |

### Fully Associative

| Replacement Policy | Hit Rate |
|--------------------|----------|
| LRU                | 0.515    |
| Pseudo LRU (tree)  | 0.455    |
| Pseudo LRU (bits)  | 0.455    |
| Random             | 0.333    |
| Improved Random    | 0.515    |

## Conclusions

These are still preliminary results, based off a small number of memory accesses. The results for all the replacement policies except the random ones are deterministic, so the results do not improve by running the tests again with the same data - a larger data set is required.

These preliminary results suggest that the performance of a cache increases as it becomes more associative  and that true LRU replacement seems to perform the best (but a slightly better than random replacement policy does almost as well for a fraction of the cost of implementation).
