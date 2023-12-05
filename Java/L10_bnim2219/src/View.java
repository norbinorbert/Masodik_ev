import javax.swing.*;
import java.awt.*;

//Boda Norbert, 521
public class View extends JPanel {
    private Virag virag;

    public View(Virag virag){
        this.virag = virag;
    }

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        g.drawImage(virag.getImg(), 0, 0, virag.getMeret(), virag.getMeret(), null);
    }
}
