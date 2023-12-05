import javax.swing.*;
import java.awt.*;

//Boda Norbert, 521
public class PizzaPanel extends JPanel {
    private Pizza pizza;

    public PizzaPanel(Pizza pizza){
        this.pizza = pizza;
    }

    @Override
    public void paintComponent(Graphics g){
        super.paintComponent(g);
        pizza.bake(g);
    }

    public Pizza getPizza(){
        return pizza;
    }

    public void setPizza(Pizza pizza){
        this.pizza = pizza;
    }
}
