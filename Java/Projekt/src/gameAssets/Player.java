package gameAssets;

import javax.imageio.ImageIO;
import javax.sound.sampled.Clip;
import java.awt.Graphics;
import java.awt.Rectangle;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
//Boda Norbert, 521

public class Player {
    public static final int DEAD = 1, JUMPING = 2, WALKING = 3;
    private boolean maxHeightReached, upwards;
    private final int topX, maxHeight;
    private int topY, width, height, status;
    private BufferedImage imgDead, imgAlive;

    //the player character
    public Player(Ground ground) {
        //image loading
        try {
            imgDead = ImageIO.read(new File("images/dead.png"));
            imgAlive = ImageIO.read(new File("images/player.png"));
        } catch (IOException e) {
            System.out.println("Couldn't load image in " + getClass().getSimpleName());
            System.exit(1);
        }

        //starting attributes
        status = WALKING;
        maxHeightReached = false;
        upwards = true;
        topX = 50;
        topY = ground.getY() - imgAlive.getHeight();
        width = imgAlive.getWidth();
        height = imgAlive.getHeight();
        maxHeight = topY - 200;
    }

    //updates the characters whereabouts based on its status
    public void update(Clip walkingSound){
        if (status == JUMPING) {
            int jumpDistance = 10;

            //going uo
            if (!maxHeightReached && upwards) {
                topY -= jumpDistance;
                width = imgAlive.getWidth();
                height = imgAlive.getHeight();
            }

            //going down
            if (!upwards) {
                topY += jumpDistance;
                width = imgAlive.getWidth();
                height = imgAlive.getHeight();
                maxHeightReached = false;
                //reached the floor
                if (topY == maxHeight + 200) {
                    walkingSound.setMicrosecondPosition(0);
                    walkingSound.start();
                    walkingSound.loop(Clip.LOOP_CONTINUOUSLY);
                    upwards = true;
                    status = WALKING;
                    width = imgAlive.getWidth();
                    height = imgAlive.getHeight();
                }
            }

            //reached the max height, going down from here
            if (topY == maxHeight) {
                maxHeightReached = true;
                upwards = false;
            }
        }
    }

    //draws the character based on its status
    public void draw(Graphics g){
        if (status == DEAD) {
            g.drawImage(imgDead, topX, topY, null);
        }
        else{
            g.drawImage(imgAlive, topX, topY, null);
        }
    }

    public int getTopX() {
        return topX;
    }

    public Rectangle getRectangle(){
        return new Rectangle(topX, topY, width, height);
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
        if(status == DEAD){
            width = imgDead.getWidth();
            height = imgDead.getHeight();
        }
        else{
            width = imgAlive.getWidth();
            height = imgAlive.getHeight();
        }
    }
}
