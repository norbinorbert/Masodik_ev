public class L01_bnim2219_2 {
    public static void main(String[] args) {
        int paros = 0, paratlan = 0;
        for (String i : args) {
            try {
                int szam = Integer.parseInt(i);
                if (szam % 2 == 0) {
                    paros += szam;
                } else {
                    paratlan += szam;
                }
            } catch (NumberFormatException ignored) {
            }
        }
        System.out.println("A paros szamok osszege: " + paros);
        System.out.println("A paratlan szamok osszege: " + paratlan);
    }
}
