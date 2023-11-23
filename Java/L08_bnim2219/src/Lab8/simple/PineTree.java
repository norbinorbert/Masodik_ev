package Lab8.simple;
import Lab8.Plant;
//Boda Norbert, 521
public class PineTree implements Plant {
    @Override
    public double getOxygenAmountPerYear(){
        return 4;
    }

    @Override
    public int getLifeTime(){
        return 4;
    }

    @Override
    public String getRepresentation(){
        return "P";
    }
}
