import java.util.List;

//Boda Norbert, 521
public interface Strategy {
    public List<Student> processFile(String fileName);
    public void printStatistics(List<Student> students);
}
