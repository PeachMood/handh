package voronova;

import java.util.Arrays;

public class Example {
    public static void main(String[] args) {
        int[][] arrays = new RandomArrays().generateArrays(5);
        int length = arrays.length;
        for (int i = 0; i < length; ++i) {
            System.out.println("Array " + i + ": " + Arrays.toString(arrays[i]));
        }
    }
}
