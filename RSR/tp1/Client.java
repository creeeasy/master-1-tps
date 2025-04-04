import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;

class Client {
    public static void main(String[] args) {
        String server_address = "localhost";
        int port = 5000;
        try (Socket socket = new Socket(server_address, port)) {
            System.out.println("\nL'addresse de server est :" + socket.getInetAddress());
            System.out.println("Le port de server est :" + socket.getPort());
            System.out.println("L'addresse de client est :" + socket.getLocalAddress());
            System.out.println("Le port de client est :" + socket.getLocalPort());

            BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
            System.out.print("enter un messge : ");
            Scanner scanner = new Scanner(System.in);
            String message = scanner.nextLine();
            scanner.close();

            System.out.println("La chaine envoye est : " + message);
            out.println(message);

            System.out.println("La chaine recu est : " + in.readLine());
            in.close();

            out.close();
            socket.close();

        } catch (IOException e) {

            e.printStackTrace();
        }
    }
}