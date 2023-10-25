package collection;

import core.Car;
//Boda Norbert, 521
public class Entry {
    private Integer key;
    private Car value;
    private Entry next;

    public Entry(Integer key, Car value, Entry next){
        this.key = key;
        this.value = value;
        this.next = next;
    }
    public Integer getKey() {
        return this.key;
    }
    public Car getValue(){
        return this.value;
    }
    public Entry getNext(){
        return this.next;
    }
}
