public class Main {
    public static void main(String[] args) {
        int n = 3;
        try {
            n = Integer.parseInt(args[0]);
        }
        catch (NumberFormatException | ArrayIndexOutOfBoundsException ignored) {}
        if(n > 10 || n <= 0){
            n = 3;
        }
        new Game(n);
    }
}
