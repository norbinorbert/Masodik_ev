import javax.swing.*;
import java.awt.*;

public class GamePanel extends JPanel {
    private String szoveg;
    private int score;
    private boolean stringVisible;
    public GamePanel(){
        stringVisible = true;
    }

    @Override
    public void paintComponent(Graphics g) {
        if(!stringVisible) {
            super.paintComponent(g);
            g.setColor(Color.RED);
            g.setFont(new Font("Times New Roman", Font.BOLD, 24));
            g.drawString(szoveg, getWidth() / 2, getHeight() / 2);
            stringVisible = true;
        }
        else {
            stringVisible = false;
        }
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public void setSzoveg(String szoveg) {
        this.szoveg = szoveg;
    }

    public String getSzoveg() {
        return szoveg;
    }
}
