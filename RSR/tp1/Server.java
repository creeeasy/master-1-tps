
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;

class Server {
    public static void main(String[] args) {
        int port = 5000;
        try {
            ServerSocket server = new ServerSocket(port);
            System.out.println("\nServer is listening to port :" + port);
            while (true) {
                Socket socket = server.accept();
                BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                PrintWriter out = new PrintWriter(socket.getOutputStream(), true);

                System.out
                        .println("Client connected : " + socket.getInetAddress() + " sur le port :" + socket.getPort());
                String message = in.readLine();
                System.out.println("Message recieved de client :" + message);
                String response = message.toUpperCase();
                out.println(response);
                System.out.println("Response renovie au client :" + response);

            }
        } catch (IOException e) {
            e.printStackTrace();

        }

    }
}