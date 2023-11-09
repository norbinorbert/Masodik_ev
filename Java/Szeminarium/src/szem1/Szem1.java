package szem1;

public class Szem1 {
    public static void main(String[] args) { //main shortcut a fejlechez
        System.out.print("Hello, World!\n");
        System.out.println("Norbi");
        //sout shortcut a kiirashoz

        //args referencia String objektumokbol allo tombre
        //args.length az objektumnak egy adattagja
        for (int i = 0; i < args.length; i++) {
            System.out.print(args[i] + " ");
        }
        System.out.println();

        //altalanositott for
        for (String i : args) {
            System.out.println(i);
        }

        //string "osszeadas"
        //automatikus tipuskonverzio (int->string)
        System.out.println(args.length + " argumentum a parancssorban.");

        //burkolo/wrapper osztalyok:
        // primitiv tipusok kore epulnek (pl: int, float stb.)
        // int -> Integer
        // double -> Double
        // stb
        //kivetelkezeles ugyanugy mukodik, mint c++ban
        for (String i : args) {
            try {
                //int-be alakit at, kivetelt valt ki ha nem tudja
                System.out.println(Integer.parseInt(i) + " ");
            } catch (NumberFormatException a) {
                System.out.println(i + " nem egesz");
            }
        }

        //dinamikus memoriafoglalas
        int[] a = new int[3];
        a[0] = 0;
        a[1] = 12;
        a[2] = 2;
        System.out.print("A tomb elemei: ");
        for (int i : a) {
            System.out.print(i + " ");
        }
    }
}
