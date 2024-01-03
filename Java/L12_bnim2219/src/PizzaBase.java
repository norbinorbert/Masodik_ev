import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

//Boda Norbert, 521
public class PizzaBase implements Pizza {
    private BufferedImage img;

    public PizzaBase(){
        try {
            img = ImageIO.read(new File("img/pizza_base.png"));
        } catch (IOException e) {
            System.out.println("Hiba a file betoltesekor");
        }
    }

    @Override
    public void bake(Graphics g) {
        g.drawImage(img, 0, 0, null);
    }

    @Override
    public int getPrice() {
        return 30;
    }

    @Override
    public String getIngredients() {
        return "Cheese ";
    }
}
