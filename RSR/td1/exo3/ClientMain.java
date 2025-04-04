import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;

public class ClientMain {

    public static void main(String[] args) throws ClassNotFoundException {
        User _client = new User("ahmed", "ali");
        String addresse = "localhost";
        int port = 5000;
        try {
            Socket socket = new Socket(addresse, port);
            ObjectOutputStream out = new ObjectOutputStream(socket.getOutputStream());
            ObjectInputStream in = new ObjectInputStream(socket.getInputStream());
            out.writeObject(_client);
            Boolean response = (Boolean) in.readObject();
            System.out.println("\nLe message recu :" + response);

        } catch (IOException e) {

            e.printStackTrace();
        }

    }
}
