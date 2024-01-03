import java.awt.*;

//Boda Norbert, 521
public abstract class PizzaIngredient implements Pizza{
    private Pizza pizza;

    public PizzaIngredient(Pizza pizza){
        this.pizza = pizza;
    }

    @Override
    public void bake(Graphics g) {
        pizza.bake(g);
    }

    @Override
    public int getPrice() {
        return pizza.getPrice();
    }

    @Override
    public String getIngredients() {
        return pizza.getIngredients();
    }
}
