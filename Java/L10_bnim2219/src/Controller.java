import java.util.Random;

//Boda Norbert, 521
public class Controller implements Runnable{
    private Virag virag;
    private View view;
    private Random r = new Random();
    public Controller(Virag virag, View view){
        this.virag = virag;
        this.view = view;
    }

    @Override
    public void run() {
        while(virag.getMeret() < virag.getMax_meret()){
            virag.setMeret(virag.getMeret() + r.nextInt(20));
            try {
                Thread.sleep(100);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
            view.repaint();
        }
    }
}
