
import java.io.*;
import java.net.*;

public class Client {
    private static final String SERVEUR_ADRESSE = "localhost";
    private static final int PORT = 12345;

    public static void main(String[] args) {
        try (Socket socket = new Socket(SERVEUR_ADRESSE, PORT);
                BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()))) {
            System.out.println("Demande d'accès à la section critique...");
            String message;
            while ((message = in.readLine()) != null) {
                System.out.println("Serveur: " + message);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
