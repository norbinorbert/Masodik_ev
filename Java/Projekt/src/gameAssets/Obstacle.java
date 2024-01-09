package gameAssets;

import java.awt.Rectangle;
import java.awt.image.BufferedImage;
//Boda Norbert, 521

public class Obstacle {
    private final BufferedImage img;
    private Rectangle hitbox;
    private boolean worthAPoint;

    //defines an obstacle on the map
    public Obstacle(BufferedImage img, Rectangle hitbox) {
        this.img = img;
        this.hitbox = hitbox;
        worthAPoint = true;
    }

    public BufferedImage getImg() {
        return img;
    }

    public Rectangle getHitbox() {
        return hitbox;
    }

    public void setHitbox(Rectangle hitbox) {
        this.hitbox = hitbox;
    }

    public boolean givesPoint() {
        return worthAPoint;
    }

    public void invalidate() {
        worthAPoint = false;
    }
}
