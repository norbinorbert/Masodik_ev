package panels;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.border.Border;
import javax.swing.border.CompoundBorder;
import javax.swing.border.EmptyBorder;
import javax.swing.border.LineBorder;
import java.awt.Color;
//Boda Norbert, 521

public class SaveScorePanel extends JPanel {
    private final JButton saveButton = new JButton("Save");
    private final JButton cancelButton = new JButton("Cancel");
    private final JTextField nameField = new JTextField();

    //panel where the player can save their score
    public SaveScorePanel(){
        setBounds(0, 0, 800, 600);
        setLayout(null);

        //button customisation
        Border line = new LineBorder(Color.BLACK);
        Border margin = new EmptyBorder(0, 0, 0, 0);
        Border compound = new CompoundBorder(line, margin);

        saveButton.setBounds(500, 50, 100, 30);
        saveButton.setBackground(new Color(255, 255, 255, 75));
        saveButton.setBorder(compound);
        saveButton.setFocusPainted(false);
        add(saveButton);

        cancelButton.setBounds(600, 50, 100, 30);
        cancelButton.setBackground(new Color(255, 255, 255, 75));
        cancelButton.setBorder(compound);
        cancelButton.setFocusPainted(false);
        add(cancelButton);

        nameField.setBounds(500, 80, 200, 30);
        add(nameField);

        //info for the player
        JLabel text1 = new JLabel("Write your name and press \"Save\" to save your score to the list");
        text1.setBounds(50, 50, 800, 25);
        add(text1);

        JLabel text2 = new JLabel("Press \"Cancel\" if you changed your mind");
        text2.setBounds(50, 75, 800, 25);
        add(text2);

        JLabel text3 = new JLabel("Note: only the first 50 characters will be used");
        text3.setBounds(50, 100, 800, 25);
        add(text3);

        JLabel background = new JLabel("", new ImageIcon("images/background.gif"), JLabel.CENTER);
        background.setBounds(0,0, 800, 600);
        add(background);
    }

    public JButton getSaveButton() {
        return saveButton;
    }

    public JButton getCancelButton() {
        return cancelButton;
    }

    public JTextField getNameField() {
        return nameField;
    }
}
