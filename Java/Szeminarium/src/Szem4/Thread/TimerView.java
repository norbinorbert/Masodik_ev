package Thread;

import javax.swing.*;
import java.awt.*;

public class TimerView extends JPanel {
    private TimerModel model;

    @Override
    public void paintComponent(Graphics g){
        System.out.println("asd");
        super.paintComponent(g);
        g.setFont(new Font("Arial", Font.BOLD, 24));
        g.drawString(model.getStart()+"", 10,10);
    }

    public TimerView(TimerModel model){
        this.model = model;
    }
}
