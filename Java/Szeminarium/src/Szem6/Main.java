import java.util.*;
import java.util.stream.Collectors;

public class Main {
    public static void main(String[] args) {
        List<Allat> allatok = new ArrayList<>();
        allatok.add(new Allat("Kutya", 5, new double[]{1.1, 2.2, 3.3}));
        allatok.add(new Allat("Macska", 12, new double[]{0.6, 1.2, 1.8}));
        allatok.add(new Allat("Poni", 15, new double[]{13.1, 21.2, 1.3}));
        allatok.add(new Allat("Macska", 11, new double[]{1, 2, 3}));
        System.out.println(allatok);

        //stream osszes elemere vegrehajtja az utasitast
        allatok.forEach(System.out::println);
        allatok.forEach(e -> e.setEletkor(e.getEletkor() + 1))
        ;
        System.out.println(allatok);
        System.out.println();

        //map visszaterit egy masik streamet
        Set<String> fajok = allatok.stream()
                .map(Allat::getFaj)
                .collect(Collectors.toSet());
        System.out.println(fajok);
        System.out.println();

        List<Allat> oregAllatok = allatok.stream()
                .filter(e -> e.getEletkor() > 10)
                .filter(e -> e.getFaj().startsWith("M"))
                .collect(Collectors.toList());
        System.out.println(oregAllatok);
        System.out.println();

        Allat a = allatok.stream()
                .filter(e -> e.getFaj().startsWith("K"))
                .findFirst()
                .orElse(null);
        System.out.println(a);
        System.out.println();

        allatok.stream()
                .filter(e -> e.getEletkor() > 10)
                .filter(e -> e.getFaj().startsWith("M"))
                .toList()
                .forEach(System.out::println);
        System.out.println();

        List<Double> atlagok = allatok.stream()
                .map(e -> Arrays.stream(e.getMeresek())
                        .average()
                        .orElse(0))
                .toList();
        atlagok.forEach(System.out::println);
        System.out.println();

        allatok.stream().map(e -> e.getFaj() + " " +
                Arrays.stream(e.getMeresek())
                        .average()
                        .orElse(0))
                .forEach(System.out::println);
        System.out.println();

        Allat legdagadtabbMacska = allatok.stream()
                .filter(e -> e.getFaj().equals("Macska"))
                .max(Comparator.comparingDouble(e -> Arrays.stream(e.getMeresek())
                        .average()
                        .orElse(0)))
                .orElse(null);
        System.out.println(legdagadtabbMacska);
        System.out.println();
    }
}
