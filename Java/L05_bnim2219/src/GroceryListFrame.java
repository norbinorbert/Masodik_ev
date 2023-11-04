import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

//Boda Norbert, 521
public class GroceryListFrame extends Frame {
    private List lista1;
    private Button gomb1;
    private Button gomb2;
    private List lista2;

    public GroceryListFrame(){
        setBounds(200, 200, 500, 500);
        setTitle("Grocery List Frame");
        setLayout(new GridLayout(1, 4));

        addWindowListener(new WindowAdapter(){
            @Override
            public void windowClosing(WindowEvent e) {
                super.windowClosing(e);
                dispose();
            }
        });

        lista1 = new List();
        lista1.setMultipleMode(true);
        add(lista1);
        lista1.add("Alma");
        lista1.add("Korte");
        lista1.add("Narancs");
        lista1.add("Szolo");
        lista1.add("Szilva");

        gomb1 = new Button("->");
        add(gomb1);
        gomb1.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String[] tmp = lista1.getSelectedItems();
                for(String i: tmp){
                    lista1.remove(i);
                    lista2.add(i);
                }
            }
        });

        gomb2 = new Button("<-");
        add(gomb2);
        gomb2.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String[] tmp = lista2.getSelectedItems();
                for(String i: tmp){
                    lista2.remove(i);
                    lista1.add(i);
                }
            }
        });

        lista2 = new List();
        lista2.setMultipleMode(true);
        add(lista2);
        lista2.add("Uborka");
        lista2.add("Repa");
        lista2.add("Paradicsom");
        lista2.add("Paprika");





        setVisible(true);
    }
}
