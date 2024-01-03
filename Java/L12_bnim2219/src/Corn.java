import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

//Boda Norbert, 521
public class Corn extends PizzaIngredient {
    private BufferedImage img;

    public Corn(Pizza p){
        super(p);
        try {
            img = ImageIO.read(new File("img/corn.png"));
        } catch (IOException e){
            System.out.println("Hiba a file betoltesekor");
        }
    }

    @Override
    public void bake(Graphics g) {
        super.bake(g);
        g.drawImage(img, 0, 0, null);
    }

    @Override
    public int getPrice() {
        return super.getPrice() + 3;
    }

    @Override
    public String getIngredients() {
        return super.getIngredients() + "Corn ";
    }
}
