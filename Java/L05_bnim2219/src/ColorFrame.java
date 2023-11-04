import java.awt.*;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.util.Random;

//Boda Norbert, 521
public class ColorFrame extends Frame {
    private Choice lista;
    private Random r;

    public ColorFrame(){
        setBounds(200, 200, 500, 500);
        setTitle("Color Frame");

        addWindowListener(new WindowAdapter(){
            @Override
            public void windowClosing(WindowEvent e) {
                super.windowClosing(e);
                dispose();
            }
        });

        r = new Random();

        lista = new Choice();
        add(lista);
        lista.add("");
        lista.add("Red");
        lista.add("Green");
        lista.add("Blue");
        lista.add("Random");

        lista.addItemListener(new ItemListener() {
            @Override
            public void itemStateChanged(ItemEvent e) {
                switch (lista.getSelectedIndex()){
                    case 0:
                        setBackground(Color.WHITE);
                        break;
                    case 1:
                        setBackground(Color.RED);
                        break;
                    case 2:
                        setBackground(Color.GREEN);
                        break;
                    case 3:
                        setBackground(Color.BLUE);
                        break;
                    case 4:
                        setBackground(new Color(r.nextInt(256), r.nextInt(256), r.nextInt(256)));
                        break;
                }
            }
        });

        setVisible(true);
    }
}
