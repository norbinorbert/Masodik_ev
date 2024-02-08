import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.SwingConstants;
import java.awt.BorderLayout;

public class Game extends JFrame {
    public static final int WIN = 0, LOSE = 1;
    private final JLabel northLabel = new JLabel(" ", SwingConstants.CENTER);
    private final JLabel southLabel = new JLabel(" ", SwingConstants.CENTER);
    private final ButtonPanel buttonPanel = new ButtonPanel();

    public Game(int n){
        setLayout(new BorderLayout());
        setBounds(100, 100, 1000, 200);
        setDefaultCloseOperation(EXIT_ON_CLOSE);

        add(northLabel, BorderLayout.NORTH);
        add(southLabel, BorderLayout.SOUTH);

        add(buttonPanel, BorderLayout.CENTER);

        Thread game = new Thread(new GameController(this, n));
        game.start();

        setVisible(true);
    }

    public void endGame(int status) {
        if (status == WIN) {
            JOptionPane.showMessageDialog(null, "Nyertél!");
            System.exit(0);
        }
        else{
            JOptionPane.showMessageDialog(null, "Vesztettél!");
            System.exit(0);
        }
    }

    public JLabel getNorthLabel() {
        return northLabel;
    }

    public JLabel getSouthLabel() {
        return southLabel;
    }

    public ButtonPanel getButtonPanel() {
        return buttonPanel;
    }
}