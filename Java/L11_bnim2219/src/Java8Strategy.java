import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

//Boda Norbert, 521
public class Java8Strategy implements Strategy{
    @Override
    public List<Student> processFile(String fileName) {
        BufferedReader a;
        try {
            a = new BufferedReader(new FileReader(fileName));
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        }

        return a.lines().map(s -> {
            String[] szavak = s.split(",");
            return new Student(szavak[0], szavak[1],
                    Arrays.stream(szavak)
                            .skip(2)
                            .mapToInt(Integer::parseInt)
                            .toArray());
        })
                .sorted((s1, s2) -> s1.getName().compareTo(s2.getName()))
                .collect(Collectors.toList());
    }

    @Override
    public void printStatistics(List<Student> students) {
        System.out.println("\n\nMean grades per student: ");
        students.stream().forEach(s -> System.out.println(s.getName() + ": " +
                                    Arrays.stream(s.getGrades())
                                            .average()
                                            .getAsDouble()));

        System.out.println("Mean of mean grades: " +
                students.stream()
                        .map(s -> Arrays.stream(s.getGrades())
                                .average().getAsDouble()
                                )
                        .mapToDouble(Double::doubleValue)
                        .average()
                        .getAsDouble());

        System.out.println("Mean of all grades: " +
                    students.stream()
                            .flatMapToInt(e -> Arrays.stream(e.getGrades()))
                            .average()
                            .getAsDouble());

        System.out.println("Male student with highest mean: " +
                students.stream()
                        .filter(e -> e.getGender().equals("male"))
                        .map(s -> s.getName() + "," + Arrays.stream(s.getGrades())
                                .average()
                                .getAsDouble())
                        .max((s1, s2) -> {
                            if(Double.parseDouble(s1.split(",")[1]) > Double.parseDouble(s2.split(",")[1])){
                                return 1;
                            }
                            else if (s1.equals(s2)) return 0;
                            else return -1;
                        })
                        .get().split(",")[0]);

        System.out.println("Female student with highest mean: " +
                students.stream()
                        .filter(e -> e.getGender().equals("female"))
                        .map(s -> s.getName() + "," + Arrays.stream(s.getGrades())
                                .average()
                                .getAsDouble())
                        .max((s1, s2) -> {
                            if(Double.parseDouble(s1.split(",")[1]) >
                                    Double.parseDouble(s2.split(",")[1])){
                                return 1;
                            }
                            else if (s1.equals(s2)) return 0;
                            else return -1;
                        })
                        .get()
                        .split(",")[0]);

        System.out.print("Student's first name that have a grade 10: ");
        students.stream()
                .filter(e -> Arrays.stream(e.getGrades())
                        .max().getAsInt() == 10)
                .map(e -> e.getName().split(" ")[0])
                .forEach(e -> System.out.print(e + ", "));
    }
}
