package Lab8.simple;
import Lab8.Plant;
//Boda Norbert, 521
public class Grass implements Plant {
    @Override
    public double getOxygenAmountPerYear(){
        return 2;
    }

    @Override
    public int getLifeTime(){
        return 2;
    }

    @Override
    public String getRepresentation(){
        return "G";
    }
}
