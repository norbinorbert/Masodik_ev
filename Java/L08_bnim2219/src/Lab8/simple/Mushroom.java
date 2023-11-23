package Lab8.simple;
import Lab8.Plant;
//Boda Norbert, 521
public class Mushroom implements Plant {
    @Override
    public double getOxygenAmountPerYear(){
        return 3;
    }

    @Override
    public int getLifeTime(){
        return 3;
    }

    @Override
    public String getRepresentation(){
        return "M";
    }
}
