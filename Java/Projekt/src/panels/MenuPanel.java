package panels;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.border.Border;
import javax.swing.border.CompoundBorder;
import javax.swing.border.EmptyBorder;
import javax.swing.border.LineBorder;
import java.awt.Color;
//Boda Norbert, 521

public class MenuPanel extends JPanel {
    private final JButton newGameButton = new JButton("New Game");
    private final JButton scoresButton = new JButton("High Scores");
    private final JButton exitButton = new JButton("Exit");

    //this panel opens when the application is started
    public MenuPanel(){
        setBounds(0, 0, 800, 600);
        setLayout(null);

        //button customisation
        Border line = new LineBorder(Color.BLACK);
        Border margin = new EmptyBorder(0, 0, 0, 0);
        Border compound = new CompoundBorder(line, margin);

        newGameButton.setBounds(50, getHeight()/4 - 50, 150, 50);
        newGameButton.setBorder(compound);
        newGameButton.setBackground(new Color(255, 255, 255, 75));
        newGameButton.setFocusPainted(false);
        add(newGameButton);

        scoresButton.setBounds(50, getHeight()/2 - 50, 150, 50);
        scoresButton.setBackground(new Color(255, 255, 255, 75));
        scoresButton.setBorder(compound);
        scoresButton.setFocusPainted(false);
        add(scoresButton);

        exitButton.setBounds(50, getHeight()*3/4 - 50, 150, 50);
        exitButton.setBackground(new Color(255, 255, 255, 75));
        exitButton.setBorder(compound);
        exitButton.setFocusPainted(false);
        add(exitButton);

        //start menu background
        JLabel background = new JLabel("", new ImageIcon("images/background.gif"), JLabel.CENTER);
        background.setBounds(0,0, 800, 600);
        add(background);
    }

    public JButton getNewGameButton() {
        return newGameButton;
    }

    public JButton getScoresButton() {
        return scoresButton;
    }

    public JButton getExitButton() {
        return exitButton;
    }
}
