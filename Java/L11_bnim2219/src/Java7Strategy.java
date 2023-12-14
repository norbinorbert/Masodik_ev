import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

//Boda Norbert, 521
public class Java7Strategy implements Strategy{
    @Override
    public List<Student> processFile(String fileName) {
        BufferedReader a;
        try {
            a = new BufferedReader(new FileReader(fileName));
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        }
        List<Student> students = new ArrayList<>();
        String sor;
        try {
            while ((sor = a.readLine()) != null) {
                String[] szavak = sor.split(",");
                ArrayList<Integer> jegyek = new ArrayList<>();
                for (int i = 2; i<szavak.length;i++){
                    jegyek.add(Integer.parseInt(szavak[i]));
                }
                int[] jegyek2 = new int[jegyek.size()];
                for (int i = 0; i < jegyek.size();i++){
                    jegyek2[i] = jegyek.get(i);
                }
                students.add(new Student(szavak[0], szavak[1], jegyek2));
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        students.sort(new Comparator<Student>() {
            @Override
            public int compare(Student o1, Student o2) {
                return o1.getName().compareTo(o2.getName());
            }
        });

        return students;
    }

    @Override
    public void printStatistics(List<Student> students) {
        double atlagok = 0;
        int osszeg = 0;
        int ossz_jegy = 0;

        double fiu_atlag = 0;
        String fiu_nev = "";

        double lany_atlag = 0;
        String lany_nev = "";

        ArrayList<String> nevek = new ArrayList<>();

        System.out.println("Mean grades per student:");
        for (Student i: students) {
            int tmp_osszeg = 0;
            int[] jegyek = i.getGrades();
            for (int k : jegyek) {
                tmp_osszeg += k;
                osszeg += k;
                ossz_jegy++;
                String nev = i.getName().split(" ")[0];
                if (k == 10 && !nevek.contains(nev)) {
                    nevek.add(nev);
                }
            }

            double atlag = (double) tmp_osszeg /  jegyek.length;
            System.out.println(i.getName() + ": " + atlag);

            atlagok += atlag;
            if(i.getGender().equals("male") && atlag > fiu_atlag){
                fiu_atlag = atlag;
                fiu_nev = i.getName();
            }

            if(i.getGender().equals("female") && atlag > lany_atlag){
                lany_atlag = atlag;
                lany_nev = i.getName();
            }
        }
        System.out.println("Mean of mean grades: " + (atlagok) / students.size());
        System.out.println("Mean of all grades: " + ((double) osszeg) / ossz_jegy);
        System.out.println("Male student with highest mean: " + fiu_nev);
        System.out.println("Female student with highest mean: " + lany_nev);

        System.out.print("Student's first name that have a grade 10: ");
        for (String nev: nevek) {
            System.out.print(nev + ", ");
        }
    }
}
