import java.io.*;
import java.net.*;
import java.util.*;

public class Lamport {
    private final int id, port;
    private final List<String> otherProcesses;
    private int clock = 0;
    private final List<Request> requestQueue = new ArrayList<>();
    private final Set<Integer> acksReceived = new HashSet<>();

    public Lamport(int id, int port, List<String> otherProcesses) {
        this.id = id;
        this.port = port;
        this.otherProcesses = otherProcesses;
    }

    public void start() {
        new Thread(this::runServer).start();

        try {
            Thread.sleep(2000);
            requestCriticalSection();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    private void requestCriticalSection() {
        clock++;
        Request myRequest = new Request(clock, id);
        requestQueue.add(myRequest);
        sortQueue();
        System.out.println("Processus " + id + " demande la section critique à t=" + clock);

        sendToAll("REQ " + clock + " " + id + " " + port);

        while (acksReceived.size() < otherProcesses.size() || requestQueue.get(0).processId != id) {
            sleep(100);
        }

        enterCriticalSection();
    }

    private void enterCriticalSection() {
        System.out.println("Processus " + id + " entre en section critique");
        sleep(5000);
        exitCriticalSection();
    }

    private void exitCriticalSection() {
        System.out.println("Processus " + id + " sort de la section critique");
        requestQueue.removeIf(r -> r.processId == id);
        sendToAll("REL " + id);
        acksReceived.clear();
    }

    private void runServer() {
        try (ServerSocket serverSocket = new ServerSocket(port)) {
            while (true) {
                Socket clientSocket = serverSocket.accept();
                new Thread(() -> handleClient(clientSocket)).start();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void handleClient(Socket socket) {
        try (BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()))) {
            String message = in.readLine();
            if (message != null) {
                processMessage(message, socket.getInetAddress().getHostAddress());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void processMessage(String message, String senderHost) {
        String[] parts = message.split(" ");
        String type = parts[0];

        switch (type) {
            case "REQ" -> {
                int timestamp = Integer.parseInt(parts[1]);
                int senderId = Integer.parseInt(parts[2]);
                int senderPort = Integer.parseInt(parts[3]);

                clock = Math.max(clock, timestamp) + 1;
                requestQueue.add(new Request(timestamp, senderId));
                sortQueue();

                sendMessage(senderHost, senderPort, "ACK " + id);
            }
            case "ACK" -> {
                int ackSenderId = Integer.parseInt(parts[1]);
                acksReceived.add(ackSenderId);
            }
            case "REL" -> {
                int senderId = Integer.parseInt(parts[1]);
                requestQueue.removeIf(r -> r.processId == senderId);
            }
        }
    }

    private void sendToAll(String message) {
        for (String process : otherProcesses) {
            String[] parts = process.split(":");
            sendMessage(parts[0], Integer.parseInt(parts[1]), message);
        }
    }

    private void sendMessage(String host, int port, String message) {
        try (Socket socket = new Socket(host, port);
                PrintWriter out = new PrintWriter(socket.getOutputStream(), true)) {
            out.println(message);
        } catch (IOException e) {
            System.err.println("Erreur d'envoi à " + host + ":" + port + " - " + e.getMessage());
        }
    }

    private void sortQueue() {
        requestQueue.sort(Comparator.comparingInt((Request r) -> r.timestamp).thenComparingInt(r -> r.processId));
    }

    private void sleep(int ms) {
        try {
            Thread.sleep(ms);
        } catch (InterruptedException ignored) {
        }
    }

    public static void main(String[] args) {
        if (args.length < 3) {
            System.out.println("Usage: java Lamport <id> <port> <host1:port1> ...");
            return;
        }

        int id = Integer.parseInt(args[0]);
        int port = Integer.parseInt(args[1]);
        List<String> others = Arrays.asList(Arrays.copyOfRange(args, 2, args.length));

        new Lamport(id, port, others).start();
    }
}

class Request {
    int timestamp, processId;

    public Request(int timestamp, int processId) {
        this.timestamp = timestamp;
        this.processId = processId;
    }
}
