import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Arrays;

public class RC4 {
    private byte[] S = new byte[256];
    private int i = 0, j = 0;

    public RC4(byte[] key) {
        init(key);
    }

    private void init(byte[] key) {
        int keyLength = key.length;
        for (int i = 0; i < 256; i++) {
            S[i] = (byte) i;
        }
        int j = 0;
        for (int i = 0; i < 256; i++) {
            j = (j + S[i] + key[i % keyLength]) & 0xFF;
            swap(S, i, j);
        }
    }

    private void swap(byte[] array, int a, int b) {
        byte temp = array[a];
        array[a] = array[b];
        array[b] = temp;
    }

    public byte[] encryptDecrypt(byte[] data) {
        byte[] output = new byte[data.length];
        for (int k = 0; k < data.length; k++) {
            i = (i + 1) & 0xFF;
            j = (j + S[i]) & 0xFF;
            swap(S, i, j);
            int rnd = S[(S[i] + S[j]) & 0xFF];
            output[k] = (byte) (data[k] ^ rnd);
        }
        return output;
    }

    public static void main(String[] args) throws IOException {
        byte[] key = "ourmassiesttekfi".getBytes();
        Path fileName = Path.of("C:\\Users\\useHP\\Desktop\\bdd_m1\\cryptography\\tp3\\message.txt");

        String message = Files.readString(fileName);
        // String message = "Hello, Hsissen Mrigla!";
        RC4 rc4 = new RC4(key);

        byte[] encrypted = rc4.encryptDecrypt(message.getBytes());
        System.out.println("\nEncrypted: " + Arrays.toString(encrypted));

        RC4 rc4Decrypt = new RC4(key);
        byte[] decrypted = rc4Decrypt.encryptDecrypt(encrypted);
        System.out.println("Decrypted: " + new String(decrypted));
    }
}
