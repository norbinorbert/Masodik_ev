import core.Car;
import collection.CarList;

//Boda Norbert, 511

public class TestCarList {
    public static void main(String[] args) {
        Car N = new Car("Nissan", 12, 5.6f);
        Car S = new Car("Seat", 12, 9.8f);
        Car V = new Car("Volkswagen", 18, 12.5f);
        Car P = new Car("Porsche", 1, 3.2f);

        CarList lista = new CarList(3);
        lista.addCar(N);
        lista.addCar(P);
        lista.addCar(S);
        lista.addCar(V);

        CarList.CarIterator i = lista.getIterator();
        while(i.hasMoreElements()){
            System.out.println(i.nextElement());
        }
    }
}
