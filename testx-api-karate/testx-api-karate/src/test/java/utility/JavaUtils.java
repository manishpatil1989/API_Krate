package utility;

import java.util.Random;

public class JavaUtils {
    public Integer getRandomNumber(int max) {
        Random rand = new Random();
        return rand.nextInt(max);
    }
}
