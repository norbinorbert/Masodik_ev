import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.time.LocalDateTime;

//Boda Norbert, 521
public class DateFrame extends JFrame {
    private JLabel label = new JLabel();
    private JButton button = new JButton("Datum");

    public DateFrame(){
        setTitle("DateFrame");
        setBounds(100, 100, 500, 500);
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        setLayout(new FlowLayout());
        add(button);
        add(label);

        button.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                label.setText(LocalDateTime.now().toString());
            }
        });

        setVisible(true);
    }
}
