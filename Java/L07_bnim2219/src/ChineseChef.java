//Boda Norbert, 521
public class ChineseChef implements Chef{
    @Override
    public Soup prepareSoup(){
        return new KlangBakKutTehSoup();
    };

    @Override
    public MainDish prepareMainDish(){
        return new KungPaoChicken();
    }
}
