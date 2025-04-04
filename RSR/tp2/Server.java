import java.io.*;
import java.net.*;
import java.util.*;

public class Server {
    static final int PORT = 12345;
    static final int TEMPS_ACCES = 20000;
    static Queue<Socket> fileAttente = new LinkedList<>();

    public static void main(String[] args) {
        try (ServerSocket serverSocket = new ServerSocket(PORT)) {
            System.out.println("\nServeur en écoute sur le port " + PORT);

            while (true) {
                Socket clientSocket = serverSocket.accept();
                System.out.println(
                        "Nouveau client connecté: " + clientSocket.getInetAddress() + ":" + clientSocket.getPort());
                fileAttente.add(clientSocket);
                gererClients();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void gererClients() {
        if (!fileAttente.isEmpty()) {
            Socket client = fileAttente.poll();
            try (PrintWriter out = new PrintWriter(client.getOutputStream(), true)) {
                out.println("Accès autorisé à la section critique.");
                System.out.println("Client " + client.getInetAddress() + ":" + client.getPort()
                        + " accède à la section critique.");
                Thread.sleep(TEMPS_ACCES);
                out.println("Fin de la section critique.");
                System.out.println("Client " + client.getInetAddress() + ":" + client.getPort()
                        + " a libéré la section critique.");
            } catch (IOException | InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
