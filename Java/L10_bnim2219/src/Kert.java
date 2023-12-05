import javax.swing.*;
import java.awt.*;
import java.util.Random;

//Boda Norbert, 521
public class Kert extends JFrame {
    private Hatter hatter;
    private Thread[] threads;
    private Virag[] viragok;
    private View[] views;
    private Controller[] controllers;
    private Random r = new Random();
    public Kert(){
        hatter = new Hatter();
        setBounds(100, 100, 1280, 729);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setResizable(false);

        hatter.setLayout(null);
        int viragok_szama = 4;
        viragok = new Virag[viragok_szama];
        views = new View[viragok_szama];
        controllers = new Controller[viragok_szama];
        threads = new Thread[viragok_szama];
        for(int i=0; i<viragok_szama; i++){
            viragok[i] = new Virag(0, r.nextInt(200) + 100);
            views[i] = new View(viragok[i]);
            hatter.add(views[i]);
            //views[i].setBackground(new Color(0,0,0,0));
            views[i].setBounds(300*i, 400, viragok[i].getMax_meret(), viragok[i].getMax_meret());
            controllers[i] = new Controller(viragok[i], views[i]);
            threads[i] = new Thread(controllers[i]);
            threads[i].start();
        }

        add(hatter);

        setVisible(true);
    }

    public static void main(String[] args) {
        new Kert();
    }
}
