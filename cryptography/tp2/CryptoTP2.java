import java.math.BigInteger;
import java.util.Random;
import java.util.Scanner;

public class CryptoTP2 {
    private static final int MODULO = 27;
    private static final Random random = new Random();

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("\nChoisissez une méthode: 1 - Chiffrement Affine, 2 - Chiffrement de Hill");
        int choice = scanner.nextInt();
        scanner.nextLine();

        if (choice == 1) {
            handleAffineCipher(scanner);
        } else if (choice == 2) {
            handleHillCipher(scanner);
        } else {
            System.out.println("Choix invalide.");
        }

        scanner.close();
    }

    private static void handleAffineCipher(Scanner scanner) {
        System.out.println("Tapez le message: ");
        String message = scanner.nextLine().toUpperCase();
        System.out.println("Tapez la valeur de a: ");
        BigInteger a = scanner.nextBigInteger();
        System.out.println("Tapez la valeur de b: ");
        BigInteger b = scanner.nextBigInteger();

        String encryptedMessage = encryptAffine(message, a, b);
        System.out.println("Le message chiffré: " + encryptedMessage);

        String decryptedMessage = decryptAffine(encryptedMessage, a, b);
        System.out.println("Le message déchiffré: " + decryptedMessage);
    }

    private static void handleHillCipher(Scanner scanner) {
        System.out.println("Pour encryption tapez 1, pour decryption tapez 2.");
        int hillChoice = scanner.nextInt();
        scanner.nextLine();

        System.out.println("Tapez le message: ");
        String message = scanner.nextLine().toUpperCase();

        if (message.length() % 2 != 0) {
            message += "X"; // Padding if length is odd
        }

        int[][] keyMatrix = { { 2, 3 }, { 1, 2 } };
        int[][] inverseMatrix = invertMatrix(keyMatrix);

        if (hillChoice == 1) {
            String encryptedMessage = encryptHill(message, keyMatrix);
            System.out.println("Le message chiffré: " + encryptedMessage);
        } else if (hillChoice == 2) {
            if (inverseMatrix == null) {
                System.out.println("La matrice de clé n'est pas inversible sous modulo 27.");
            } else {
                String decryptedMessage = decryptHill(message, inverseMatrix);
                System.out.println("Le message déchiffré: " + decryptedMessage);
            }
        } else {
            System.out.println("Choix invalide.");
        }
    }

    static String encryptAffine(String message, BigInteger a, BigInteger b) {
        StringBuilder cipherText = new StringBuilder();
        for (char ch : message.toCharArray()) {
            int m = (ch == ' ') ? 26 : (ch - 'A');
            int c = a.multiply(BigInteger.valueOf(m)).add(b).mod(BigInteger.valueOf(MODULO)).intValue();
            cipherText.append((c == 26) ? ' ' : (char) ('A' + c));
        }
        return cipherText.toString();
    }

    static String decryptAffine(String cipher, BigInteger a, BigInteger b) {
        StringBuilder plainText = new StringBuilder();
        BigInteger aInverse = EuclideEtendu.InverseMod(a, BigInteger.valueOf(MODULO));
        if (aInverse == null)
            return "Impossible de déchiffrer";

        for (char ch : cipher.toCharArray()) {
            int c = (ch == ' ') ? 26 : (ch - 'A');
            int m = (aInverse.multiply(BigInteger.valueOf(c).subtract(b)).mod(BigInteger.valueOf(MODULO)).intValue()
                    + MODULO) % MODULO;
            plainText.append((m == 26) ? ' ' : (char) ('A' + m));
        }
        return plainText.toString();
    }

    static String encryptHill(String message, int[][] keyMatrix) {
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < message.length(); i += 2) {
            int[] vector = { (message.charAt(i) - 'A'), (message.charAt(i + 1) - 'A') };
            int[] cipherVector = {
                    (keyMatrix[0][0] * vector[0] + keyMatrix[0][1] * vector[1]) % MODULO,
                    (keyMatrix[1][0] * vector[0] + keyMatrix[1][1] * vector[1]) % MODULO
            };
            result.append((char) ('A' + cipherVector[0])).append((char) ('A' + cipherVector[1]));
        }
        return result.toString();
    }

    static String decryptHill(String cipher, int[][] inverseMatrix) {
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < cipher.length(); i += 2) {
            int[] vector = { (cipher.charAt(i) - 'A'), (cipher.charAt(i + 1) - 'A') };
            int[] plainVector = {
                    (inverseMatrix[0][0] * vector[0] + inverseMatrix[0][1] * vector[1]) % MODULO,
                    (inverseMatrix[1][0] * vector[0] + inverseMatrix[1][1] * vector[1]) % MODULO
            };
            result.append((char) ('A' + plainVector[0])).append((char) ('A' + plainVector[1]));
        }
        return result.toString();
    }

    static int[][] invertMatrix(int[][] matrix) {
        int det = (matrix[0][0] * matrix[1][1] - matrix[0][1] * matrix[1][0]) % MODULO;
        det = (det + MODULO) % MODULO; // Ensure positive determinant

        BigInteger detInverse = EuclideEtendu.InverseMod(BigInteger.valueOf(det), BigInteger.valueOf(MODULO));
        if (detInverse == null)
            return null;

        int[][] inverse = new int[][] {
                { (matrix[1][1] * detInverse.intValue()) % MODULO,
                        (-matrix[0][1] * detInverse.intValue() + MODULO) % MODULO },
                { (-matrix[1][0] * detInverse.intValue() + MODULO) % MODULO,
                        (matrix[0][0] * detInverse.intValue()) % MODULO }
        };

        return inverse;
    }
}

class EuclideEtendu {
    public static BigInteger InverseMod(BigInteger a, BigInteger n) {
        BigInteger[] result = EuclideEtendu(a, n);
        return result[0].equals(BigInteger.ONE) ? result[1].mod(n) : null;
    }

    public static BigInteger[] EuclideEtendu(BigInteger a, BigInteger b) {
        BigInteger r = a, rPrime = b, u = BigInteger.ONE, v = BigInteger.ZERO, uPrime = BigInteger.ZERO;
        while (!rPrime.equals(BigInteger.ZERO)) {
            BigInteger q = r.divide(rPrime);
            BigInteger temp = rPrime;
            rPrime = r.subtract(q.multiply(rPrime));
            r = temp;
            temp = uPrime;
            uPrime = u.subtract(q.multiply(uPrime));
            u = temp;
        }
        return new BigInteger[] { r, u, v };
    }
}
