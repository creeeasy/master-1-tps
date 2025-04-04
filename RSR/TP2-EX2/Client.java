import java.io.*;
import java.net.*;

public class Client {
    private static final String SERVER_ADDRESS = "localhost";
    private static final int PORT = 1234;

    public static void main(String[] args) {
        try (Socket socket = new Socket(SERVER_ADDRESS, PORT);
             BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
             PrintWriter out = new PrintWriter(socket.getOutputStream(), true)) {

            System.out.println("Connecté au serveur. Attente de l'autorisation...");

            String response;
            while ((response = in.readLine()) != null) {
                System.out.println(response);
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
