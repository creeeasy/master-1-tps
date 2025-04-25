import java.net.*;
import java.util.*;

public class UDPServerMulticast {
    public static void main(String[] args) throws Exception {
        DatagramSocket socket = new DatagramSocket(1234);
        InetAddress group = InetAddress.getByName("230.0.0.1");
        int multicastPort = 1235;
        byte[] buffer = new byte[1024];
        int secretNumber = new Random().nextInt(100) + 1;
        boolean gameWon = false;

        System.out.println("Multicast Server started. Secret number is: " + secretNumber);

        while (!gameWon) {
            DatagramPacket request = new DatagramPacket(buffer, buffer.length);
            socket.receive(request);
            String guessStr = new String(request.getData(), 0, request.getLength());

            int guessedNumber;
            try {
                guessedNumber = Integer.parseInt(guessStr);
            } catch (NumberFormatException e) {
                continue;
            }

            String response;
            if (guessedNumber < secretNumber) {
                response = "Trop petit";
            } else if (guessedNumber > secretNumber) {
                response = "Trop grand";
            } else {
                response = "Gagné ! Le numéro était " + secretNumber;
                gameWon = true;
            }

            String playerInfo = request.getAddress().getHostAddress() + ":" + request.getPort();
            String message = "Joueur " + playerInfo + " a proposé " + guessedNumber + " : " + response;

            DatagramPacket multicastMessage = new DatagramPacket(
                    message.getBytes(),
                    message.length(),
                    group,
                    multicastPort);
            socket.send(multicastMessage);
        }

        socket.close();
        System.out.println("Jeu terminé. Serveur arrêté.");
    }
}
