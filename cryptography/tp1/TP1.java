import java.math.BigInteger;
import java.util.Scanner;

class TP1 {
    public void InverseMod(BigInteger a, BigInteger n, BigInteger[] result) {
        BigInteger d = result[0];
        BigInteger x = result[1];

        if (!d.equals(BigInteger.valueOf(1))) {
            System.out.println("\nThere's no solution because a mod n isn't 1.");
        } else {
            System.out.println("Inverse of " + a + " mod " + n + " is: " + x.mod(n));

        }
    }

    public BigInteger[] EuclideEtendu(BigInteger a, BigInteger b) {
        BigInteger r = a;
        BigInteger r_prime = b;
        BigInteger u = BigInteger.valueOf(1);
        BigInteger v = BigInteger.valueOf(0);
        BigInteger u_prime = BigInteger.valueOf(0);
        BigInteger v_prime = BigInteger.valueOf(1);
        BigInteger rs, us, vs;
        BigInteger q;

        while (!r_prime.equals(BigInteger.valueOf(0))) {
            q = r.divide(r_prime);
            rs = r;
            us = u;
            vs = v;
            r = r_prime;
            u = u_prime;
            v = v_prime;
            r_prime = rs.subtract(q.multiply(r_prime));
            u_prime = us.subtract(q.multiply(u_prime));
            v_prime = vs.subtract(q.multiply(v_prime));
        }
        return new BigInteger[] { r, u, v };
    }

    public static void main(String[] args) {
        BigInteger a, b;
        Scanner scanner = new Scanner(System.in);
        System.err.println("\nGive me the a's value : ");
        a = scanner.nextBigInteger();
        System.err.println("\nGive me the b's value : ");
        b = scanner.nextBigInteger();
        scanner.close();

        TP1 obj = new TP1();
        BigInteger[] result = obj.EuclideEtendu(a, b);
        System.out.println("r = " + result[0] + ", u = " + result[1] + ", v = " + result[2]);

        BigInteger n = b;
        obj.InverseMod(a, n, obj.EuclideEtendu(a, n));
    }
}
