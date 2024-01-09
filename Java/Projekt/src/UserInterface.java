import panels.GamePanel;
import panels.MenuPanel;
import panels.SaveScorePanel;
import panels.ScoresPanel;

import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.UnsupportedAudioFileException;
import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.CardLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.IOException;
//Boda Norbert, 521

//main frame
public class UserInterface extends JFrame implements ActionListener {
    //application start
    public static void main(String[] args) {
        new UserInterface();
    }

    //different menus are depicted with a card layout
    private final JPanel cardPanel = new JPanel();
    private final CardLayout layout = new CardLayout();
    private final MenuPanel menu = new MenuPanel();
    private final GamePanel game = new GamePanel();
    private final ScoresPanel scores = new ScoresPanel();
    private final SaveScorePanel saveScore = new SaveScorePanel();

    //sounds played with Clips
    private Clip backgroundMusic, buttonSound;

    public UserInterface(){
        cardPanel.setLayout(layout);
        add(cardPanel);

        //adding the panels to the cardLayout
        menu.getNewGameButton().addActionListener(this);
        menu.getScoresButton().addActionListener(this);
        menu.getExitButton().addActionListener(this);
        cardPanel.add(menu, "Menu");

        game.getMenuButton().addActionListener(this);
        game.getExitButton().addActionListener(this);
        game.getSaveScoreButton().addActionListener(this);
        cardPanel.add(game, "Game");

        scores.getMenuButton().addActionListener(this);
        cardPanel.add(scores, "Scores");

        saveScore.getSaveButton().addActionListener(this);
        saveScore.getCancelButton().addActionListener(this);
        cardPanel.add(saveScore, "Save Score");

        //loading menu music
        try {
            AudioInputStream audioInputStream = AudioSystem.getAudioInputStream(
                    new File("audio/background_music.wav"));
            backgroundMusic = AudioSystem.getClip();
            backgroundMusic.open(audioInputStream);
            backgroundMusic.start();
            backgroundMusic.loop(Clip.LOOP_CONTINUOUSLY);

            audioInputStream = AudioSystem.getAudioInputStream(new File("audio/button_sound.wav"));
            buttonSound = AudioSystem.getClip();
            buttonSound.open(audioInputStream);
        } catch (UnsupportedAudioFileException | IOException | LineUnavailableException ignored) {
            System.out.println("Couldn't load sound in" + getClass().getSimpleName());
            System.exit(1);
        }

        //general settings
        setResizable(false);
        setTitle("Game");
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setBounds(100, 100, 800, 600);
        setVisible(true);
    }

    //action listener for button presses:
    // - changes the shown panel on the cardLayout
    // - starts/stops music or game
    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource().equals(menu.getNewGameButton())){
            backgroundMusic.stop();
            backgroundMusic.setMicrosecondPosition(0);
            buttonSound.stop();
            buttonSound.setMicrosecondPosition(0);
            buttonSound.start();
            layout.show(cardPanel, "Game");
            game.restartGame();
        }
        if(e.getSource().equals(menu.getScoresButton())){
            buttonSound.stop();
            buttonSound.setMicrosecondPosition(0);
            buttonSound.start();
            layout.show(cardPanel, "Scores");
            scores.showScores();
        }
        if (e.getSource().equals(menu.getExitButton())){
            backgroundMusic.close();
            buttonSound.stop();
            buttonSound.setMicrosecondPosition(0);
            buttonSound.start();
            System.exit(0);
        }

        if(e.getSource().equals(scores.getMenuButton())){
            buttonSound.stop();
            buttonSound.setMicrosecondPosition(0);
            buttonSound.start();
            layout.show(cardPanel, "Menu");
        }

        if(e.getSource().equals(game.getMenuButton())){
            buttonSound.stop();
            buttonSound.setMicrosecondPosition(0);
            buttonSound.start();
            backgroundMusic.start();
            backgroundMusic.loop(Clip.LOOP_CONTINUOUSLY);
            layout.show(cardPanel, "Menu");
            game.endGame(GamePanel.END_GAME_WITHOUT_DEATH_SOUND);
        }
        if(e.getSource().equals(game.getExitButton())){
            buttonSound.stop();
            buttonSound.setMicrosecondPosition(0);
            buttonSound.start();
            System.exit(0);
        }
        if(e.getSource().equals(game.getSaveScoreButton())){
            buttonSound.stop();
            buttonSound.setMicrosecondPosition(0);
            buttonSound.start();
            backgroundMusic.start();
            backgroundMusic.loop(Clip.LOOP_CONTINUOUSLY);
            layout.show(cardPanel, "Save Score");
        }

        if(e.getSource().equals(saveScore.getCancelButton())){
            buttonSound.stop();
            buttonSound.setMicrosecondPosition(0);
            buttonSound.start();
            layout.show(cardPanel, "Menu");
        }
        if(e.getSource().equals(saveScore.getSaveButton())){
            buttonSound.stop();
            buttonSound.setMicrosecondPosition(0);
            buttonSound.start();
            String playerName = saveScore.getNameField().getText().strip();
            playerName = playerName.substring(0, Math.min(playerName.length(), 50));
            game.saveScore(playerName);
            layout.show(cardPanel, "Scores");
            scores.showScores();
        }
    }
}