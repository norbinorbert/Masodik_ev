import javax.swing.*;
import javax.swing.filechooser.FileNameExtensionFilter;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.io.*;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.util.Arrays;
import java.util.List;

//Boda Norbert, 521
public class PizzaFrame extends JFrame implements ItemListener, ActionListener {
    private PizzaPanel panel;
    private JCheckBox corn = new JCheckBox("Corn");
    private JCheckBox mushroom = new JCheckBox("Mushroom");
    private JCheckBox olive = new JCheckBox("Olive");
    private JCheckBox salami = new JCheckBox("Salami");
    private JCheckBox tomato = new JCheckBox("Tomato");
    private JLabel recept = new JLabel();
    private JLabel ar = new JLabel();
    private JMenuItem save = new JMenuItem("Save");
    private JMenuItem load = new JMenuItem("Load");
    public PizzaFrame(){
        setTitle("Pizza");
        setBounds(100, 100, 600, 600);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        panel = new PizzaPanel(new PizzaBase());
        Pizza p = panel.getPizza();
        System.out.println(p.getIngredients() + p.getPrice());
        add(panel, BorderLayout.CENTER);

        JPanel segedPanel = new JPanel();
        segedPanel.setLayout(new GridLayout(5, 1));
        add(segedPanel, BorderLayout.EAST);
        segedPanel.add(corn);
        segedPanel.add(mushroom);
        segedPanel.add(olive);
        segedPanel.add(salami);
        segedPanel.add(tomato);

        JPanel segedPanel2 = new JPanel();
        segedPanel2.setLayout(new FlowLayout());
        add(segedPanel2, BorderLayout.SOUTH);
        recept.setText("Ingredients: " + p.getIngredients() + " | ");
        ar.setText("Price: " + p.getPrice());
        segedPanel2.add(recept);
        segedPanel2.add(ar);

        corn.addItemListener(this);
        mushroom.addItemListener(this);
        olive.addItemListener(this);
        salami.addItemListener(this);
        tomato.addItemListener(this);

        JMenuBar menuBar = new JMenuBar();
        JMenu menu = new JMenu("Options");
        add(menuBar, BorderLayout.NORTH);
        menuBar.add(menu);
        save.addActionListener(this);
        menu.add(save);
        load.addActionListener(this);
        menu.add(load);
        setVisible(true);
    }
    @Override
    public void itemStateChanged(ItemEvent e) {
        if (e.getStateChange() == ItemEvent.SELECTED) {
            if (e.getItem().equals(corn)) {
                Pizza p = panel.getPizza();
                panel.setPizza(new Corn(p));
            }
            else if (e.getItem().equals(mushroom)) {
                Pizza p = panel.getPizza();
                panel.setPizza(new Mushroom(p));
            }
            else if (e.getItem().equals(olive)) {
                Pizza p = panel.getPizza();
                panel.setPizza(new Olive(p));
            }
            else if (e.getItem().equals(salami)) {
                Pizza p = panel.getPizza();
                panel.setPizza(new Salami(p));
            }
            else if (e.getItem().equals(tomato)) {
                Pizza p = panel.getPizza();
                panel.setPizza(new Tomato(p));
            }
        }
        else{
            if (e.getItem().equals(corn)) {
                panel.setPizza(ujPizza("Corn", panel.getPizza().getIngredients()));
            }
            else if (e.getItem().equals(mushroom)) {
                panel.setPizza(ujPizza("Mushroom", panel.getPizza().getIngredients()));
            }
            else if (e.getItem().equals(olive)) {
                panel.setPizza(ujPizza("Olive", panel.getPizza().getIngredients()));
            }
            else if (e.getItem().equals(salami)) {
                panel.setPizza(ujPizza("Salami", panel.getPizza().getIngredients()));
            }
            else if (e.getItem().equals(tomato)) {
                panel.setPizza(ujPizza("Tomato", panel.getPizza().getIngredients()));
            }
        }
        recept.setText("Ingredients: " + panel.getPizza().getIngredients() + " | ");
        ar.setText("Price: " + panel.getPizza().getPrice());
    }
    public Pizza ujPizza(String hianyzoHozzavalo, String jelenlegi){
        List<String> hozzavalok = Arrays.stream(jelenlegi.split(" "))
                .filter(s -> s.compareTo(hianyzoHozzavalo) != 0)
                .filter(s -> s.compareTo(new PizzaBase().getIngredients().strip()) != 0)
                .toList();

        Pizza[] seged = new Pizza[hozzavalok.size() + 1];
        seged[0] = new PizzaBase();
        int i = 1;
        for (String h : hozzavalok) {
            Class<Pizza> hozzavalo;
            try {
                hozzavalo = (Class<Pizza>) Class.forName(h);
            } catch (ClassNotFoundException ex) {
                throw new RuntimeException(ex);
            }

            Constructor<Pizza> constructor;
            try {
                constructor = hozzavalo.getConstructor(Pizza.class);
            } catch (NoSuchMethodException ex) {
                throw new RuntimeException(ex);
            }

            try {
                seged[i] = constructor.newInstance(seged[i-1]);
            } catch (InstantiationException | IllegalAccessException | InvocationTargetException ex) {
                System.out.println(ex.toString());
            }
            i++;
        }
        return seged[seged.length - 1];
    }
    public static void main(String[] args) {
        new PizzaFrame();
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if(e.getSource().equals(save)){
            try {
                JFileChooser chooser = new JFileChooser("./");
                FileNameExtensionFilter filter = new FileNameExtensionFilter(".txt files", "txt");
                chooser.setFileFilter(filter);
                chooser.showOpenDialog(getParent());
                String fileName = chooser.getSelectedFile().getPath();

                BufferedWriter kimenet = new BufferedWriter(new FileWriter(fileName));
                kimenet.write(panel.getPizza().getIngredients());
                kimenet.close();
            } catch (IOException ex) {
                throw new RuntimeException(ex);
            }
            catch (NullPointerException ignored){};
        }
        else if(e.getSource().equals(load)) {
            try {
                JFileChooser chooser = new JFileChooser("./");
                FileNameExtensionFilter filter = new FileNameExtensionFilter(".txt files", "txt");
                chooser.setFileFilter(filter);
                chooser.showOpenDialog(getParent());
                String fileName = chooser.getSelectedFile().getName();

                BufferedReader bemenet = new BufferedReader(new FileReader(fileName));
                String hozzavalok = bemenet.readLine();
                Pizza p = ujPizza("", hozzavalok);
                corn.setSelected(false);
                mushroom.setSelected(false);
                olive.setSelected(false);
                salami.setSelected(false);
                tomato.setSelected(false);
                for (String hozzavalo : hozzavalok.split(" ")) {
                    switch (hozzavalo) {
                        case "Corn" -> corn.setSelected(true);
                        case "Mushroom" -> mushroom.setSelected(true);
                        case "Olive" -> olive.setSelected(true);
                        case "Salami" -> salami.setSelected(true);
                        case "Tomato" -> tomato.setSelected(true);
                    }
                }
                panel.setPizza(p);
                bemenet.close();
            } catch(IOException ex){
                throw new RuntimeException(ex);
            }
            catch (NullPointerException ignored){}
        }
    }
}
