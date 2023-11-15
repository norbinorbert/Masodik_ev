//Boda Norbert, 521
public class KlangBakKutTehSoup implements Soup{
    @Override
    public void associateMainDish(MainDish d) {
        System.out.println("A " + this + " leveshez a " + d + " főételt társítottam.");
    }
    @Override
    public String toString(){
        return getClass().getSimpleName();
    }
}
