import java.io.*;
import java.net.*;
import java.util.concurrent.locks.*;

public class MultiThreadedServer {
    private static final int PORT = 1234;
    private static final Lock lock = new ReentrantLock();

    public static void main(String[] args) {
        try (ServerSocket serverSocket = new ServerSocket(PORT)) {
            System.out.println("Serveur en attente de connexions...");

            while (true) {
                Socket clientSocket = serverSocket.accept();
                System.out.println("Nouveau client connecté : " + clientSocket.getInetAddress());

                new ClientHandler(clientSocket, lock).start();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

class ClientHandler extends Thread {
    private Socket clientSocket;
    private Lock lock;

    public ClientHandler(Socket socket, Lock lock) {
        this.clientSocket = socket;
        this.lock = lock;
    }

    @Override
    public void run() {
        try (
                BufferedReader in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
                PrintWriter out = new PrintWriter(clientSocket.getOutputStream(), true)) {
            out.println("Attente de la section critique...");
            Thread.sleep(5000);

            lock.lock();
            try {
                out.println("Accès accordé !");
                System.out.println("Client " + clientSocket.getInetAddress() + " accède à la section critique.");
                Thread.sleep(10000);
                out.println("Fin de la section critique.");
            } finally {
                lock.unlock();
            }

            System.out.println("Client " + clientSocket.getInetAddress() + " a libéré la section critique.");

        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }
}
