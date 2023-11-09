import javax.swing.*;
import java.awt.*;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.Random;

//Boda Norbert, 521
public class PushFrame extends JFrame implements MouseListener {
    private JButton button  = new JButton("Push me!");
    Random r = new Random();

    public PushFrame(){
        setTitle("PushFrame");
        setBounds(0, 0, 500, 500);
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        setLayout(null);
        setMinimumSize(new Dimension(200, 200));
        add(button);
        button.setBounds(r.nextInt(this.getWidth()-100), r.nextInt(this.getHeight()-50), 100, 50);

        button.addMouseListener(this);
        setVisible(true);
    }

    @Override
    public void mouseClicked(MouseEvent e) {}

    @Override
    public void mousePressed(MouseEvent e) {}

    @Override
    public void mouseReleased(MouseEvent e) {}

    @Override
    public void mouseEntered(MouseEvent e) {
        Point B = button.getLocationOnScreen();
        Point M = MouseInfo.getPointerInfo().getLocation();
        while(M.x >= B.x && M.x <= B.x + 100 && M.y >= B.y && M.y <= B.y+50) {
            button.setBounds(r.nextInt(this.getWidth()-100), r.nextInt(this.getHeight()-50), 100, 50);
            B = button.getLocationOnScreen();
            M = MouseInfo.getPointerInfo().getLocation();
        }
    }

    @Override
    public void mouseExited(MouseEvent e) {}
}
