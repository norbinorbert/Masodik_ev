public class L01_bnim2219_3 {
    public static void main(String[] args) {
        for (String i : args) {
            for (int j = 0; j < i.length(); j++) {
                char karakter = i.charAt(j);
                char kiirando_karakter = karakter;
                if (Character.isLowerCase(karakter)) {
                    kiirando_karakter = Character.toUpperCase(karakter);
                } else if (Character.isUpperCase(karakter)) {
                    kiirando_karakter = Character.toLowerCase(karakter);
                }
                System.out.print(kiirando_karakter);
            }
            System.out.print(" ");
        }
    }
}
