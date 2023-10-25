import collection.VehicleIterator;
import collection.VehicleList;
import core.Airplane;
import core.Car;
import core.Vehicle;

//Boda Norbert, 521
public class TestVehicleList {
    public static void main(String[] args) {
        VehicleList a = new VehicleList(10);
        Car N = new Car("Nissan", 10);
        Car S = new Car("Seat", 12);
        Airplane B = new Airplane("Boeing", 5, 71.0f);
        Car P = new Car("Porsche", 3);
        Airplane A = new Airplane("Airbus", 10, 73);

        a.addVehicle(N);
        a.addVehicle(S);
        a.addVehicle(B);
        a.addVehicle(P);
        a.addVehicle(A);

        VehicleIterator i1 = a.getForwardIterator();
        while(i1.hasMoreElements()){
            Vehicle x = i1.nextElement();
            System.out.println(x);
            x.numberOfWheels();
        }
        System.out.println();
        VehicleIterator i2 = a.getBackwardIterator();
        while (i2.hasMoreElements()){
            Vehicle x = i2.nextElement();
            System.out.println(x);
            x.numberOfWheels();
        }
    }
}