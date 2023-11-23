package Lab8.simple;
import Lab8.Plant;
//Boda Norbert, 521
public class OakTree implements Plant {
    @Override
    public double getOxygenAmountPerYear(){
        return 5;
    }

    @Override
    public int getLifeTime(){
        return 5;
    }

    @Override
    public String getRepresentation(){
        return "O";
    }
}
