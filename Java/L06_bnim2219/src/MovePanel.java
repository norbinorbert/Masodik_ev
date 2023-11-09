import javax.swing.*;
import java.awt.*;
//Boda Norbert, 521
public class MovePanel extends JPanel {

    private int posX;
    private int posY;
    private int circleSize;

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        g.fillOval(posX, posY, circleSize, circleSize);
    }

    public MovePanel(){
        posX = 100;
        posY = 100;
        circleSize = 50;
    }
    public int getPosX() {
        return posX;
    }
    public int getPosY() {
        return posY;
    }
    public void setPosX(int posX){
        this.posX = posX;
    }
    public void setPosY(int posY){
        this.posY = posY;
    }
    public void setCircleSize(int circleSize){
        this.circleSize = circleSize;
    }
    public int getCircleSize(){
        return circleSize;
    }
}
