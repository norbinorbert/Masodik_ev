package Draw;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class DrawLine extends JFrame implements ActionListener{
    @Override
    public void actionPerformed(ActionEvent e) {
        try {
            leftPanel.setX1(Integer.parseInt(text[0].getText()));
        }
        catch (NumberFormatException exception){
            leftPanel.setX1(0);
        }
        try{
            leftPanel.setY1(Integer.parseInt(text[1].getText()));
        }
        catch (NumberFormatException exception){
            leftPanel.setY1(0);
        }
        try{
            leftPanel.setX2(Integer.parseInt(text[2].getText()));
        }
        catch (NumberFormatException exception){
            leftPanel.setX2(0);
        }
        try {
            leftPanel.setY2(Integer.parseInt(text[3].getText()));
        }
        catch (NumberFormatException exception){
            leftPanel.setY2(0);
        }
        repaint();
    }

    private JButton button = new JButton("DRAW");
    private JPanel rightPanel = new JPanel();
    private LeftPanel leftPanel = new LeftPanel();
    private JTextField text[];
    public DrawLine(){
        setBounds(100, 100, 800, 600);
        setLayout(new BorderLayout());
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        setTitle("DrawLine");

        add(button, BorderLayout.SOUTH);
        button.addActionListener(this);

        text = new JTextField[4];
        for(int i=0;i<4;i++){
            text[i] = new JTextField(4);
        }
        add(rightPanel, BorderLayout.EAST);
        rightPanel.setLayout(new GridLayout(4, 4));
        rightPanel.add(new JLabel("x1"));
        rightPanel.add(text[0]);
        rightPanel.add(new JLabel("y1"));
        rightPanel.add(text[1]);
        rightPanel.add(new JLabel("x2"));
        rightPanel.add(text[2]);
        rightPanel.add(new JLabel("y2"));
        rightPanel.add(text[3]);

        add(leftPanel, BorderLayout.CENTER);
        leftPanel.setBackground(Color.GREEN);
        setVisible(true);
    }

    public static void main(String[] args) {
        new DrawLine();
    }
}
