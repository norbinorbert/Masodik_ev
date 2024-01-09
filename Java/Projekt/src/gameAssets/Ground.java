package gameAssets;

import javax.imageio.ImageIO;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
//Boda Norbert, 521

public class Ground {
    private int x1, x2;
    private final int y;
    private BufferedImage img;

    //defines the ground on which the character runs and obstacles spawn on
    public Ground(){;
        try {
            img = ImageIO.read(new File("images/ground.jpg"));
        } catch (IOException e) {
            System.out.println("Couldn't load image in " + getClass().getSimpleName());
            System.exit(1);
        }
        x1 = 0;
        x2 = x1 + img.getWidth();
        y = 500;
    }

    //updates the ground, so it seems like the player is moving
    public void update(){
        x1 -= 5;
        x2 -= 5;
        if(x2 == 0){
            x1 = x2;
            x2 = x1 + img.getWidth();
        }
    }

    //draws the ground
    public void draw(Graphics g){
        g.drawImage(img, x1, y, null);
        g.drawImage(img, x2, y, null);
    }

    public int getY() {
        return y;
    }
}
