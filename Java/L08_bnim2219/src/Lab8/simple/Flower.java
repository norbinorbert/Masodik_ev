package Lab8.simple;
import Lab8.Plant;
//Boda Norbert, 521
public class Flower implements Plant {
    @Override
    public double getOxygenAmountPerYear(){
        return 1;
    }

    @Override
    public int getLifeTime(){
        return 1;
    }

    @Override
    public String getRepresentation(){
        return "F";
    }
}
