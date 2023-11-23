package Lab8.composite;
import Lab8.Plant;
import java.util.ArrayList;

//Boda Norbert, 521
public class Forest implements Plant{
    private ArrayList<Plant> list;

    public Forest(){
        list = new ArrayList<Plant>(10);
    }

    public void add(Plant p){
        list.add(p);
    }

    public void remove(Plant p){
        list.remove(p);
    }

    public double getOxygenAmountPerYear(){
        double sum = 0;
        for (Plant i : list){
            sum = sum + i.getOxygenAmountPerYear();
        }
        return sum;
    }

    public int getLifeTime(){
        int lifeTime = 0;
        for (Plant i : list){
            lifeTime = Math.max(lifeTime, i.getLifeTime());
        }
        return lifeTime;
    }

    public String getRepresentation(){
        String tmp = "{";
        for (Plant i : list){
            tmp = tmp + i.getRepresentation() + ", ";
        }
        tmp = tmp.substring(0, tmp.length() - 2);
        return tmp + "}";
    }
}
