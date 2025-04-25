import java.net.*;
import java.util.*;
import java.util.concurrent.*;

public class UDPClientMulticast {

    private static volatile boolean gameRunning = true;
    private static final long TIME_LIMIT = 2 * 60 * 1000;

    public static void main(String[] args) throws Exception {
        DatagramSocket socket = new DatagramSocket();
        InetAddress serverAddress = InetAddress.getByName("localhost");
        InetAddress group = InetAddress.getByName("230.0.0.1");
        int serverPort = 1234;
        int multicastPort = 1235;

        Thread listener = new Thread(() -> {
            try (MulticastSocket multicastSocket = new MulticastSocket(multicastPort)) {
                multicastSocket.joinGroup(group);
                byte[] buffer = new byte[1024];

                while (gameRunning) {
                    DatagramPacket packet = new DatagramPacket(buffer, buffer.length);
                    multicastSocket.receive(packet);
                    String msg = new String(packet.getData(), 0, packet.getLength());
                    System.out.println("\n[Serveur] " + msg);

                    if (msg.contains("Gagné")) {
                        gameRunning = false;
                    }
                }

                multicastSocket.leaveGroup(group);
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
        listener.start();

        Scanner scanner = new Scanner(System.in);
        long startTime = System.currentTimeMillis();

        ExecutorService executor = Executors.newSingleThreadExecutor();

        while (gameRunning) {
            long timeElapsed = System.currentTimeMillis() - startTime;
            long timeRemaining = TIME_LIMIT - timeElapsed;

            if (timeRemaining <= 0) {
                System.out.println("\nTemps écoulé ! Vous avez été éliminé.");
                gameRunning = false;
                break;
            }

            System.out.print("\nEntrez votre proposition (il vous reste "
                    + (timeRemaining / 1000) + "s) : ");

            Future<String> futureInput = executor.submit(scanner::nextLine);

            try {
                String guess = futureInput.get(timeRemaining, TimeUnit.MILLISECONDS);

                DatagramPacket request = new DatagramPacket(
                        guess.getBytes(),
                        guess.length(),
                        serverAddress,
                        serverPort);
                socket.send(request);

            } catch (TimeoutException e) {
                System.out.println("\nTemps écoulé sans réponse ! Vous avez été éliminé.");
                gameRunning = false;
                break;
            } catch (Exception e) {
                e.printStackTrace();
                break;
            }
        }

        executor.shutdownNow();
        socket.close();
        scanner.close();
        System.out.println("Fin du jeu pour ce client.");
    }
}
