import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.util.Random;

public class ColoredFrame extends Frame implements ActionListener{
    private Panel panel;
    private Panel panel2;
    private Button button1;
    private Button button2;
    private Button button3;
    private Button button4;
    private Random r = new Random();

    public ColoredFrame(){
        setBounds(200,200,500,500);
        setTitle("Colored Frame");

        addWindowListener(new WindowAdapter(){
            @Override
            public void windowClosing(WindowEvent e){
                System.exit(0);
            }
        });

        setLayout(new BorderLayout());
        panel = new Panel();
        panel.setBackground(Color.black);
        add(panel, BorderLayout.CENTER); //panel hozzaadva a keret kozepso reszehez

        panel2 = new Panel();
        add(panel2, BorderLayout.SOUTH);
        panel2.setLayout(new GridLayout(1, 4));

        button1 = new Button("red");
        panel2.add(button1);
        button1.addActionListener(this);

        button2 = new Button("green");
        panel2.add(button2);
        button2.addActionListener(this);

        button3 = new Button("blue");
        panel2.add(button3);
        button3.addActionListener(this);

        button4 = new Button("random");
        panel2.add(button4);
        button4.addActionListener(this);

        setVisible(true);
    }

    @Override
    public void actionPerformed(ActionEvent e){
        if(e.getSource() == button1){
            panel.setBackground(Color.RED);
        }
        else if(e.getSource() == button2){
            panel.setBackground(Color.GREEN);
        }
        else if(e.getSource() == button3){
            panel.setBackground(Color.BLUE);
        }
        else{
            panel.setBackground(new Color(r.nextInt(256), r.nextInt(256), r.nextInt(256)));
        }
    }

    public static void main(String[] args) {
        new ColoredFrame();
    }
}
