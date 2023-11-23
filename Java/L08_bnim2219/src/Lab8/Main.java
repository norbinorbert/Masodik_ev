package Lab8;

import Lab8.composite.Field;
import Lab8.composite.Forest;
import Lab8.simple.*;

//Boda Norbert, 521
public class Main {
    public static void main(String[] args) {
        Forest forest = new Forest();
        Field f1 = new Field();
        f1.add(new Flower());
        f1.add(new Grass());
        forest.add(f1);
        Field f2 = new Field();
        f2.add(new Mushroom());
        f2.add(new Mushroom());
        forest.add(f2);
        forest.add(new PineTree());
        forest.add(new OakTree());

        System.out.println("Erdo:");
        System.out.println(forest.getRepresentation());
        System.out.println(forest.getOxygenAmountPerYear());
        System.out.println(forest.getLifeTime());

        System.out.println("Mezo1:");
        System.out.println(f1.getOxygenAmountPerYear());
        System.out.println(f1.getLifeTime());

        System.out.println("Mezo2:");
        System.out.println(f2.getOxygenAmountPerYear());
        System.out.println(f2.getLifeTime());

        Plant p = new PineTree();
        f1.add(p);
        System.out.println("-\n" + f1.getOxygenAmountPerYear());
        f1.remove(p);
        System.out.println(f1.getOxygenAmountPerYear());

        forest.add(p);
        System.out.println("- \n" + forest.getOxygenAmountPerYear());
        forest.remove(p);
        System.out.println(forest.getOxygenAmountPerYear());
    }
}