package collection;

import core.Car;
//Boda Norbert, 521
public class MyHashMap {
    private Entry[] entries;

    public MyHashMap(Integer size){
        entries = new Entry[size];
    }

    public void put(Integer key, Car value){
        if(key < 1000 || key > 9999){
            System.out.println("A kulcs negyjegyu szam kell, hogy legyen!");
            return;
        }
        if(containsKey(key)){
            System.out.println("Mar letezik ilyen kulcs!");
            return;
        }
        int index = hashFunction(key);
        Entry seged = new Entry(key, value, entries[index]);
        entries[index] = seged;
    }

    public Car get(Integer key){
        int index = hashFunction(key);
        Entry seged = entries[index];
        while (seged != null){
            if(seged.getKey().equals(key)){
                return seged.getValue();
            }
            seged = seged.getNext();
        }
        return null;
    }

    public boolean containsKey(Integer key){
        int index = hashFunction(key);
        Entry seged = entries[index];
        while(seged != null){
            if(seged.getKey().equals(key)){
                return true;
            }
            seged = seged.getNext();
        }
        return false;
    }

    private int hashFunction(Integer key){
        return key % entries.length;
    }
}
