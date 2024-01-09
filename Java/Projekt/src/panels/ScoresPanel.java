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
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
//Boda Norbert, 521

public class ScoresPanel extends JPanel {
    private final JButton menuButton = new JButton("Menu");
    private final JLabel[] scoreRepresentation;

    //shows the top 10 saved scores
    public ScoresPanel() {
        setLayout(null);

        //button customisation
        Border line = new LineBorder(Color.BLACK);
        Border margin = new EmptyBorder(0, 0, 0, 0);
        Border compound = new CompoundBorder(line, margin);

        menuButton.setFocusPainted(false);
        menuButton.setBackground(new Color(0xFF, 0xF9, 0xED));
        menuButton.setBorder(compound);
        menuButton.setBounds(160, 15, 200, 50);
        add(menuButton);

        //scores are represented as labels for design's sake
        scoreRepresentation = new JLabel[10];
        int x_offset = 175, y_offset = 40;
        for (int i = 1; i <= 10; i++) {
            scoreRepresentation[i - 1] = new JLabel(i + ". ");
            scoreRepresentation[i - 1].setBounds(x_offset, y_offset, 500, 100);
            add(scoreRepresentation[i-1]);
            y_offset += 48;
        }

        JLabel background = new JLabel("", new ImageIcon("images/background2.png"), JLabel.CENTER);
        background.setBounds(0,0, 800, 600);
        add(background);
    }

    //scores are stored in the "scores.txt" file
    //scores update in real time, in case the player gets a new high score
    public void showScores(){
        String[] names;
        try {
            BufferedReader file = new BufferedReader(new FileReader("scores.txt"));
            names = file.lines().toArray(String[]::new);
        } catch (FileNotFoundException ignored) {
            names = new String[0];
        }

        int i=0;
        while (i < names.length && i < 10){
            scoreRepresentation[i].setText(scoreRepresentation[i].getText().split(" ")[0]);
            scoreRepresentation[i].setText(scoreRepresentation[i].getText() + " " + names[i]);
            i++;
        }
    }

    public JButton getMenuButton() {
        return menuButton;
    }
}
