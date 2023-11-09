import javax.swing.*;
import java.awt.*;

public class SwingFrame extends JFrame {
    private JLabel label;
    private SwingPanel panel;
    public SwingFrame(){
        setBounds(200, 200, 500, 500);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout());
        setTitle("xD");

        label = new JLabel("Kor");
        add(label, BorderLayout.SOUTH);
        panel = new SwingPanel();
        add(panel, BorderLayout.CENTER);

        setVisible(true);
    }

    public static void main(String[] args) {
        new SwingFrame();
    }
}
