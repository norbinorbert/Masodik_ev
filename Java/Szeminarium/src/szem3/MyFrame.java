import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

public class MyFrame extends Frame implements ActionListener{
    private Button gomb;
    private Label label;
    public MyFrame(){
        this.setBounds(200, 200, 300, 300); //keret szelessege es magassaga
        this.setTitle("Negyzet");

        this.setLayout(new FlowLayout()); //elrendezi a kerethez hozzaadott komponenseket

        gomb = new Button("Gomb");
        this.add(gomb);
        gomb.addActionListener(this);

        label = new Label("Label");
        this.add(label);

        //keret bezarasa
        this.addWindowListener(new WindowAdapter(){
            @Override
            public void windowClosing(WindowEvent e){
                super.windowClosing(e);
                System.exit(0);
            }
        });

        this.setVisible(true);
    }

    public static void main(String[] args) {
        new MyFrame();
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        System.out.println("Button pressed");
        label.setText("Button pressed");
    }
}
