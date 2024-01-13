import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class GameFrame extends JFrame implements ActionListener {
    public static void main(String[] args) {
        int ismetlesek = 5;
        try {
            if (args.length > 0) {
                ismetlesek = Integer.parseInt(args[0]);
            }
        }
        catch (NumberFormatException e){
            System.out.println("Nem szam");
            System.exit(1);
        }
        new GameFrame(ismetlesek);
    }

    private GamePanel gamePanel = new GamePanel();
    private JButton igen = new JButton("IGEN");
    private JButton nem = new JButton("NEM");

    GameFrame(int ismetlesek){
        setBounds(100, 100, 800, 600);
        setDefaultCloseOperation(EXIT_ON_CLOSE);

        JPanel seged = new JPanel();
        add(seged, BorderLayout.SOUTH);
        seged.add(igen);
        igen.addActionListener(this);
        igen.setVisible(false);

        seged.add(nem);
        nem.addActionListener(this);
        nem.setVisible(false);
        add(gamePanel, BorderLayout.CENTER);

        GameController gameController = new GameController(ismetlesek, gamePanel, this);
        Thread t = new Thread(gameController);
        t.start();


        setVisible(true);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if(e.getSource().equals(igen)){
            if(Integer.parseInt(gamePanel.getSzoveg()) % 3 == 0){
                gamePanel.setScore(gamePanel.getScore() + 1);
            }
            //nem.setVisible(false);
            igen.setVisible(false);
        }
        if(e.getSource().equals(nem)){
            if(Integer.parseInt(gamePanel.getSzoveg()) % 3 != 0){
                gamePanel.setScore(gamePanel.getScore() + 1);
            }
            //igen.setVisible(false);
            nem.setVisible(false);
        }
    }

    public JButton getIgen() {
        return igen;
    }

    public JButton getNem() {
        return nem;
    }
}
