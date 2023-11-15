//Boda Norbert, 521
public class Menu {
    private Soup soup;
    private MainDish mainDish;

    public void createMenu(Chef c){
        soup = c.prepareSoup();
        mainDish = c.prepareMainDish();
        soup.associateMainDish(mainDish);
    }

    public static void main(String[] args) {
        Menu chinese = new Menu();
        chinese.createMenu(new ChineseChef());
        Menu indian = new Menu();
        chinese.createMenu(new IndianChef());
    }
}
