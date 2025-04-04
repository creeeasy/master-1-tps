import java.nio.ByteBuffer;

public class XTEA {
    private static final int ROUNDS = 32;
    private static final int DELTA = 0x9E3779B9;
    private int[] key = new int[4];

    public XTEA(byte[] key) {
        if (key.length != 16) {
            throw new IllegalArgumentException("Key must be 128 bits (16 bytes)");
        }
        ByteBuffer buffer = ByteBuffer.wrap(key);
        for (int i = 0; i < 4; i++) {
            this.key[i] = buffer.getInt();
        }
    }

    public byte[] encrypt(byte[] data) {
        if (data.length != 8) {
            throw new IllegalArgumentException("Data block must be 64 bits (8 bytes)");
        }
        ByteBuffer buffer = ByteBuffer.wrap(data);
        int v0 = buffer.getInt();
        int v1 = buffer.getInt();
        int sum = 0;

        for (int i = 0; i < ROUNDS; i++) {
            v0 += ((v1 << 4 ^ v1 >>> 5) + v1) ^ (sum + key[sum & 3]);
            sum += DELTA;
            v1 += ((v0 << 4 ^ v0 >>> 5) + v0) ^ (sum + key[(sum >>> 11) & 3]);
        }

        ByteBuffer out = ByteBuffer.allocate(8);
        out.putInt(v0);
        out.putInt(v1);
        return out.array();
    }

    public byte[] decrypt(byte[] data) {
        if (data.length != 8) {
            throw new IllegalArgumentException("Data block must be 64 bits (8 bytes)");
        }
        ByteBuffer buffer = ByteBuffer.wrap(data);
        int v0 = buffer.getInt();
        int v1 = buffer.getInt();
        int sum = DELTA * ROUNDS;

        for (int i = 0; i < ROUNDS; i++) {
            v1 -= ((v0 << 4 ^ v0 >>> 5) + v0) ^ (sum + key[(sum >>> 11) & 3]);
            sum -= DELTA;
            v0 -= ((v1 << 4 ^ v1 >>> 5) + v1) ^ (sum + key[sum & 3]);
        }

        ByteBuffer out = ByteBuffer.allocate(8);
        out.putInt(v0);
        out.putInt(v1);
        return out.array();
    }
}
