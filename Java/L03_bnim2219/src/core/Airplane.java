//Boda Norbert, 521
package core;

public class Airplane implements Vehicle {
    private String type;
    private int age;
    private float length;

    public Airplane(String type, int age, float length){
        this.type = type;
        this.age = age;
        this.length = length;
    }

    @Override
    public String toString(){
        return "type: " + type + "   age: " + age + "   length: " + length;
    }

    @Override
    public void numberOfWheels() {
        System.out.println("The plane has 3 wheels");
    }
}
