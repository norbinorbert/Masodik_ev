package Lab8.composite;
import Lab8.Plant;

import java.util.HashSet;

//Boda Norbert, 521
public class Field implements Plant{
    private HashSet<Plant> set;

    public Field(){
        set = new HashSet<Plant>(10);
    }

    public void add(Plant p){
        set.add(p);
    }

    public void remove(Plant p){
        set.remove(p);
    }

    public double getOxygenAmountPerYear(){
        double sum = 0;
        for (Plant i : set){
            sum = sum + i.getOxygenAmountPerYear();
        }
        return sum;
    }

    public int getLifeTime(){
        int lifeTime = 0;
        for (Plant i : set){
            lifeTime = Math.max(lifeTime, i.getLifeTime());
        }
        return lifeTime;
    }

    public String getRepresentation(){
        String tmp = "[";
        for (Plant i : set){
            tmp = tmp + i.getRepresentation() + ", ";
        }
        tmp = tmp.substring(0, tmp.length()-2);
        return tmp + "]";
    }
}
