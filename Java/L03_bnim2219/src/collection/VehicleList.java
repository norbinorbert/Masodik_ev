//Boda Norbert, 521
package collection;

import core.Vehicle;

public class VehicleList {
    private int current;
    private Vehicle[] vehicles;

    public VehicleList(int n){
        current = 0;
        vehicles = new Vehicle[n];
    }

    public void addVehicle(Vehicle tmp){
        try{
            vehicles[current] = tmp;
            current++;
        }
        catch (ArrayIndexOutOfBoundsException e){
            System.out.println("Array full");
        }
    }

    public class VehicleForwardIterator implements VehicleIterator{
        private int index;

        public VehicleForwardIterator(){
            index = 0;
        }

        @Override
        public boolean hasMoreElements(){
            return index != current;
        }

        @Override
        public Vehicle nextElement(){
            return vehicles[index++];
        }
    }

    public class VehicleBackwardIterator implements VehicleIterator{
        private int index;

        public VehicleBackwardIterator(){
            index = current;
        }
        @Override
        public boolean hasMoreElements(){
            return index != 0;
        }

        @Override
        public Vehicle nextElement(){
            return vehicles[--index];
        }
    }

    public VehicleIterator getForwardIterator(){
        return new VehicleForwardIterator();
    }

    public VehicleIterator getBackwardIterator(){
        return new VehicleBackwardIterator();
    }
}
