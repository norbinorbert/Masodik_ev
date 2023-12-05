import javax.swing.*;

//Boda Norbert, 521
public class PizzaFrame extends JFrame {
    private PizzaPanel panel;

    public PizzaFrame(){
        setTitle("Pizza");
        setBounds(100, 100, 500, 500);
        setDefaultCloseOperation(EXIT_ON_CLOSE);

        Pizza p = new Olive(new Corn(new Salami(new Mushroom(new Tomato(new PizzaBase())))));
        panel = new PizzaPanel(p);
        System.out.println(p.getIngredients() + p.getPrice());

        add(panel);
        setVisible(true);
    }

    public static void main(String[] args) {
        new PizzaFrame();
    }
}
