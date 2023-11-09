import javax.swing.*;
import java.awt.*;

public class SwingPanel extends JPanel {

    @Override
    public void paintComponent(Graphics g){
        super.paintComponent(g); //kirajzol egy szurke panelt
        g.setColor(Color.RED);
        g.fillOval(200, 200, 200, 200);
    }
}
