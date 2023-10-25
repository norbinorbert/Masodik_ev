//Boda Norbert, 521
package core;
public class Car implements Vehicle {
    private String type;
    private int age;

    public Car(String type, int age){
        this.type = type;
        this.age = age;
    }

    @Override
    public String toString(){
        return "Type: " + type + "   Age: " + age;
    }

    @Override
    public void numberOfWheels(){
        System.out.println("The car has 4 wheels");
    }
}
