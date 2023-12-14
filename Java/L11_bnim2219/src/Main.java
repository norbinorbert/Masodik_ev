//Boda Norbert, 521
public class Main {
    public static void main(String[] args) {
        Strategy a = new Java7Strategy();
        a.printStatistics(a.processFile("data.txt"));

        Strategy b = new Java8Strategy();
        b.printStatistics(b.processFile("data.txt"));
    }
}