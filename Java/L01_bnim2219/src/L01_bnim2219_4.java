public class L01_bnim2219_4 {
    public static void main(String[] args) {
        int n;
        try {
            String parameter = args[0];
            n = Integer.parseInt(parameter);
        } catch (NumberFormatException | ArrayIndexOutOfBoundsException a) {
            n = 10;
        }

        int[][] a = new int[n][];
        for (int i = 0; i < n; i++) {
            a[i] = new int[i + 1];
        }

        int szamlalo = 1;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < a[i].length; j++) {
                a[i][j] = szamlalo++;
                System.out.print(a[i][j] + " ");
            }
            System.out.println();
        }
    }
}
