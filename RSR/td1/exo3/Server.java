
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.ServerSocket;
import java.net.Socket;

public class Server {

    public static void main(String[] args) {
        int port = 5000;
        try {

            ServerSocket _serverSocket = new ServerSocket(port);
            Socket socket = _serverSocket.accept();
            ObjectOutputStream out = new ObjectOutputStream(socket.getOutputStream());
            ObjectInputStream in = new ObjectInputStream(socket.getInputStream());
            User user = (User) in.readObject();
            System.out
                    .print("User envoye, User name : " + user.getUsername() + " ,User's Password :"
                            + user.getPassword());
            out.writeObject(true);
        } catch (Exception e) {
        }
    }

}
