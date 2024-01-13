import java.util.Random;

public class GameController implements Runnable{
    private Random r;
    private int ismetlesek;
    private GamePanel panel;
    private GameFrame frame;

    public GameController(int ismetlesek, GamePanel panel, GameFrame frame){
        r = new Random();
        this.ismetlesek = ismetlesek;
        this.panel = panel;
        this.frame = frame;
    }

    @Override
    public void run() {
        try {
            for(int i=0;i<ismetlesek;i++) {
                panel.setSzoveg(String.valueOf(r.nextInt(100)));
                panel.repaint();
                Thread.sleep(2000);
                frame.getIgen().setVisible(true);
                frame.getNem().setVisible(true);
                Thread.sleep(1000);
                frame.getIgen().setVisible(false);
                frame.getNem().setVisible(false);
            }
            panel.setSzoveg("Score: " + panel.getScore());
            panel.repaint();
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }
}

