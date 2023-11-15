package Thread;

import javax.swing.*;
import java.awt.*;
import java.util.Random;

public class TimerFrame extends JFrame {
    private TimerModel[] models;
    private TimerView[] views;
    private TimerControl[] controls;
    private Thread[] threads;
    private Random r = new Random();
    public TimerFrame(){
        setLayout(new GridLayout(2, 2));
        setBounds(100, 100, 400, 400);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setTitle("Timer");

        models = new TimerModel[4];
        views = new TimerView[4];
        controls = new TimerControl[4];
        threads = new Thread[4];
        for(int i=0; i<4; i++){
            models[i] = new TimerModel(0, r.nextInt(60));
            views[i] = new TimerView(models[i]);
            add(views[i]);
            controls[i] = new TimerControl(models[i], views[i]);
            threads[i] = new Thread(controls[i]);
            threads[i].start();
        }

        setVisible(true);
    }

    public static void main(String[] args) {
        new TimerFrame();
    }
}
