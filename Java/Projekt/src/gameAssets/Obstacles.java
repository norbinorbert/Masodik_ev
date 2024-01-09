package gameAssets;

import javax.imageio.ImageIO;
import java.awt.Graphics;
import java.awt.Rectangle;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Random;
//Boda Norbert, 521

public class Obstacles {
    private static final String[] obstacleList = {"creeper", "vindicator", "zombie"};
    private final Obstacle[] obstacles;
    private final Random r = new Random();
    private final BufferedImage[] images;
    private final Ground ground;
    private static final int distanceBetweenObstacles = 600;

    //defines all the obstacles on the map
    public Obstacles(Ground ground){
        this.ground = ground;

        //loads up the images used for the obstacles
        images = new BufferedImage[obstacleList.length];
        try {
            for(int i=0; i<images.length;i++) {
                String fileName = "images/" + obstacleList[i] + ".png";
                images[i] = ImageIO.read(new File(fileName));
            }
        } catch (IOException e) {
            System.out.println("Couldn't load image in " + getClass().getSimpleName());
            System.exit(1);
        }

        //randomly generates 10 obstacles at the start, these will be updated and regenerated
        //as the game goes on
        obstacles = new Obstacle[10];
        int topX = 800, groundY = ground.getY();
        for(int i=0;i<obstacles.length;i++){
            int index = r.nextInt(images.length);
            int topY = groundY - images[index].getHeight();
            obstacles[i] = new Obstacle(images[index],
                    new Rectangle(topX, topY, images[index].getWidth(), images[index].getHeight()));
            topX += distanceBetweenObstacles;
        }
    }

    //updates all the obstacle whereabouts
    public void update(){
        for (int i=0;i<obstacles.length;i++) {
            Rectangle hitbox = obstacles[i].getHitbox();
            obstacles[i].setHitbox(new Rectangle(hitbox.x - 10, hitbox.y, hitbox.width, hitbox.height));
            if(hitbox.x <= 0){
                int index = r.nextInt(images.length);
                int newX = Arrays.stream(obstacles)
                        .max(Comparator.comparingInt(e->e.getHitbox().x))
                        .get()
                        .getHitbox().x + distanceBetweenObstacles;
                int newY = ground.getY() - images[index].getHeight();
                obstacles[i] = new Obstacle(images[index],
                        new Rectangle(newX, newY, images[index].getWidth(), images[index].getHeight()));
            }
        }
    }

    //draws all the obstacles
    public void draw(Graphics g){
        for (Obstacle obstacle : obstacles) {
            g.drawImage(obstacle.getImg(), obstacle.getHitbox().x, obstacle.getHitbox().y, null);
        }
    }

    public Obstacle[] getObstacles() {
        return obstacles;
    }
}
