import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

//Boda Norbert, 521
public class MoveCircleFrame extends JFrame {

    private JButton fel = new JButton("↑");
    private JButton jobb = new JButton("→");
    private JButton le = new JButton("↓");
    private JButton bal = new JButton("←");
    private MovePanel panel = new MovePanel();

    public MoveCircleFrame(){
        setTitle("MoveCircleFrame");
        setBounds(100, 100, 500, 500);
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        setLayout(new BorderLayout());
        setResizable(false);
        add(panel, BorderLayout.CENTER);
        add(fel, BorderLayout.NORTH);
        add(jobb, BorderLayout.EAST);
        add(le, BorderLayout.SOUTH);
        add(bal, BorderLayout.WEST);

        int eltolas = 50;
        fel.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if(panel.getPosY() >= eltolas){
                    panel.setPosY(panel.getPosY() - eltolas);
                }
                if(panel.getPosY() < eltolas){
                    panel.setPosY(0);
                }
                repaint();
            }
        });

        jobb.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if(panel.getPosX() + eltolas <= panel.getWidth() - panel.getCircleSize()) {
                    panel.setPosX(panel.getPosX() + eltolas);
                }
                else{
                    panel.setPosX(panel.getWidth() - panel.getCircleSize());
                }
                repaint();
            }
        });

        le.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if(panel.getPosY() + eltolas <= panel.getHeight() - panel.getCircleSize()) {
                    panel.setPosY(panel.getPosY() + eltolas);
                }
                else{
                    panel.setPosY(panel.getHeight() - panel.getCircleSize());
                }
                repaint();
            }
        });

        bal.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if(panel.getPosX() >= eltolas) {
                    panel.setPosX(panel.getPosX() - eltolas);
                }
                if(panel.getPosX() < eltolas){
                    panel.setPosX(0);
                }
                repaint();
            }
        });

        setVisible(true);
    }
}
