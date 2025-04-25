import java.nio.ByteBuffer;

public class XTEA {
    private static final int ROUNDS = 32;
    private static final int DELTA = 0x9E3779B9;
    private final int[] key = new int[4];

    public XTEA(byte[] keyBytes) {
        if (keyBytes.length != 16)
            throw new IllegalArgumentException("Key must be 128 bits (16 bytes)");
        ByteBuffer buffer = ByteBuffer.wrap(keyBytes);
        for (int i = 0; i < 4; i++) {
            key[i] = buffer.getInt();
        }
    }

    public byte[] encryptBlock(byte[] block) {
        if (block.length != 8)
            throw new IllegalArgumentException("Block must be 64 bits (8 bytes)");
        ByteBuffer buffer = ByteBuffer.wrap(block);
        int v0 = buffer.getInt();
        int v1 = buffer.getInt();
        int sum = 0;

        for (int i = 0; i < ROUNDS; i++) {
            v0 += ((v1 << 4 ^ v1 >>> 5) + v1) ^ (sum + key[sum & 3]);
            sum += DELTA;
            v1 += ((v0 << 4 ^ v0 >>> 5) + v0) ^ (sum + key[(sum >>> 11) & 3]);
        }

        ByteBuffer result = ByteBuffer.allocate(8);
        result.putInt(v0).putInt(v1);
        return result.array();
    }

    public byte[] decryptBlock(byte[] block) {
        if (block.length != 8)
            throw new IllegalArgumentException("Block must be 64 bits (8 bytes)");
        ByteBuffer buffer = ByteBuffer.wrap(block);
        int v0 = buffer.getInt();
        int v1 = buffer.getInt();
        int sum = DELTA * ROUNDS;

        for (int i = 0; i < ROUNDS; i++) {
            v1 -= ((v0 << 4 ^ v0 >>> 5) + v0) ^ (sum + key[(sum >>> 11) & 3]);
            sum -= DELTA;
            v0 -= ((v1 << 4 ^ v1 >>> 5) + v1) ^ (sum + key[sum & 3]);
        }

        ByteBuffer result = ByteBuffer.allocate(8);
        result.putInt(v0).putInt(v1);
        return result.array();
    }

    public static void main(String[] args) {
        byte[] key = "1234567890ABCDEF".getBytes(); // 16-byte key
        byte[] plainBlock = "OURMASSI".getBytes(); // 8-byte plaintext

        XTEA xtea = new XTEA(key);

        byte[] encrypted = xtea.encryptBlock(plainBlock);
        byte[] decrypted = xtea.decryptBlock(encrypted);

        System.out.println("Original:   " + new String(plainBlock));
        System.out.println("Encrypted:  " + bytesToHex(encrypted));
        System.out.println("Decrypted:  " + new String(decrypted));
    }

    private static String bytesToHex(byte[] bytes) {
        StringBuilder sb = new StringBuilder();
        for (byte b : bytes)
            sb.append(String.format("%02X", b));
        return sb.toString();
    }
}
