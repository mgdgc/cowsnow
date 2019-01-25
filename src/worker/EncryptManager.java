package worker;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

public class EncryptManager {

    public static String createSalt() {
        String pattern = "(^[a-zA-Z0-9!@#$^%&*()_]*$)";
        Random random = new Random(System.currentTimeMillis());

        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < 16; i++) {

            String s = String.valueOf((char) random.nextInt());
            if (s.matches(pattern)) {
                builder.append(s);
            } else {
                i--;
            }
        }

        return builder.toString();
    }

    public static String getHash(int howMuchToDigest, String pw, String salt) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.reset();
            md.update(salt.getBytes());
            byte[] digest = md.digest(pw.getBytes(StandardCharsets.UTF_8));
            for (int i = 0; i < howMuchToDigest; i++) {
                digest = md.digest(digest);
            }

            StringBuilder builder = new StringBuilder();
            for (byte b : digest) {
                builder.append(String.format("%x", b & 0xff));
            }
            return builder.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return null;
    }

}
