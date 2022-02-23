package voronova;

import java.util.*;
import java.util.stream.Stream;

/**
 * A class containing a public method {@link #generateArrays(int)} for solving a test task for the development school Heads x Hands.
 */
public class RandomArrays {
    /**
     * A set containing the sizes of all created arrays.
     */
    private Set<Integer> sizes;
    private Random random;

    public RandomArrays() {
        sizes = new HashSet<>();
        random = new Random();
    }

    /**
     * Returns a random size for an array from 1 to bound, not in a set sizes.
     *
     * @param bound - the upper bound (exclusive). Must be positive.
     * @return random number.
     */
    private int getRandomSize(int bound) {
        if (bound <= 0) {
            throw new IllegalArgumentException("The value of the \"bound\" parameter must be positive.");
        }
        int size = random.nextInt(bound);
        while (sizes.contains(size) || size == 0) {
            size = random.nextInt(bound);
        }
        sizes.add(size);
        return size;
    }

    /**
     * Generates an array consisting of n arrays of random size filled with random numbers.
     * Array sizes do not match. Arrays in even positions are sorted in ascending order, in odd ones - in descending order.
     *
     * @param n - number of arrays.
     * @return array of n arrays.
     */
    public int[][] generateArrays(int n) {
        if (n <= 0) {
            throw new IllegalArgumentException("The value of the \"n\" parameter must be positive.");
        }
        int[][] arrays = new int[n][];
        for (int i = 0; i < n; ++i) {
            int size = getRandomSize(2 * n);
            if (i % 2 == 0) {
                arrays[i] = random.ints(size)
                        .sorted()
                        .toArray();
            } else {
                arrays[i] = Stream.generate(random::nextInt)
                        .limit(size)
                        .sorted((a, b) -> Integer.compare(b, a))
                        .mapToInt(Integer::valueOf)
                        .toArray();
            }
        }
        return arrays;
    }
}