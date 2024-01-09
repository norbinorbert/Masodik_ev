package panels;

import gameAssets.GameController;
import gameAssets.Ground;
import gameAssets.Obstacles;
import gameAssets.Player;

import javax.imageio.ImageIO;
import javax.sound.sampled.*;
import javax.swing.AbstractAction;
import javax.swing.JButton;
import javax.swing.JComponent;
import javax.swing.JPanel;
import javax.swing.KeyStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.event.ActionEvent;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Arrays;
//Boda Norbert, 521

public class GamePanel extends JPanel {
    public static final boolean END_GAME_WITH_DEATH_SOUND = true, END_GAME_WITHOUT_DEATH_SOUND = false;
    private final JButton menuButton = new JButton("Menu");
    private final JButton exitButton = new JButton("Exit");
    private final JButton saveScoreButton = new JButton("Save Score");
    private final JButton restartButton = new JButton("Restart");
    private Thread game;
    private boolean gameRunning;
    private int score, highScore;
    private Player player;
    private Obstacles obstacles;
    private Ground ground;
    private String playerName;
    private BufferedImage sun;
    private Clip walkingSound, jumpSound, deathSound, buttonSound;

    //depicts the game which is played
    public GamePanel(){
        setLayout(null);
        setFocusable(true);

        //button customisation
        setBackground(new Color(0x8B, 0xBD, 0xFF));
        menuButton.setBounds(0,0,200,50);
        menuButton.setContentAreaFilled(false);
        menuButton.setFocusPainted(false);
        add(menuButton);

        saveScoreButton.setBounds(200, 0, 200, 50);
        saveScoreButton.setContentAreaFilled(false);
        saveScoreButton.setFocusPainted(false);
        saveScoreButton.setVisible(false);
        add(saveScoreButton);

        restartButton.setBounds(400, 0, 200, 50);
        restartButton.setContentAreaFilled(false);
        restartButton.setFocusPainted(false);
        //action listener for restarting the game
        restartButton.addActionListener(e -> {
            buttonSound.stop();
            buttonSound.setMicrosecondPosition(0);
            buttonSound.start();
            restartGame();
        });
        restartButton.setVisible(false);
        add(restartButton);

        exitButton.setBounds(600, 0, 200, 50);
        exitButton.setContentAreaFilled(false);
        exitButton.setFocusPainted(false);
        add(exitButton);

        //SPACE is the only button used to play the game;
        //input is recorded using KeyStroke and ActionMap
        setInputMap(WHEN_ANCESTOR_OF_FOCUSED_COMPONENT, getInputMap());
        getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW).put(KeyStroke.getKeyStroke(' '), "space pressed");
        getActionMap().put("space pressed", new AbstractAction() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if(player.getStatus() != Player.DEAD){
                    if(!gameRunning){
                        gameRunning = true;
                        restartGame();
                        game.start();
                        player.setStatus(Player.WALKING);
                        walkingSound.start();
                    }
                    if(player.getStatus() != Player.JUMPING) {
                        player.setStatus(Player.JUMPING);
                        walkingSound.stop();
                        jumpSound.stop();
                        jumpSound.setMicrosecondPosition(0);
                        jumpSound.start();
                    }
                }
            }
        });

        //load the image of the sun
        try {
            sun = ImageIO.read(new File("images/sun.png"));
        } catch (IOException e) {
            System.out.println("Couldn't load image in " + getClass().getSimpleName());
            System.exit(1);
        }

        //load sound files
        try {
            AudioInputStream audioInputStream = AudioSystem.getAudioInputStream(
                    new File("audio/walking_sounds.wav"));
            walkingSound = AudioSystem.getClip();
            walkingSound.open(audioInputStream);

            audioInputStream = AudioSystem.getAudioInputStream(new File("audio/jump_sound.wav"));
            jumpSound = AudioSystem.getClip();
            jumpSound.open(audioInputStream);

            audioInputStream = AudioSystem.getAudioInputStream(new File("audio/death_sound.wav"));
            deathSound = AudioSystem.getClip();
            deathSound.open(audioInputStream);

            audioInputStream = AudioSystem.getAudioInputStream(new File("audio/button_sound.wav"));
            buttonSound = AudioSystem.getClip();
            buttonSound.open(audioInputStream);
        } catch (UnsupportedAudioFileException | IOException | LineUnavailableException ignored) {
            System.out.println("Couldn't load sound in" + getClass().getSimpleName());
            System.exit(2);
        }
    }

    //draws the game components and shows the score
    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        g.drawImage(sun, 0, 0, null);
        g.setFont(new Font("TimesRoman", Font.BOLD, 12));
        if(!gameRunning){
            g.drawString("Press SPACE to start running!", getWidth()/2 - 75, 75);
        }
        g.drawString("Score: " + score, getWidth() - 100, 75);
        g.drawString("High Score: " + highScore, getWidth() - 100, 75+g.getFontMetrics().getHeight());
        player.draw(g);
        obstacles.draw(g);
        ground.draw(g);
    }

    //resets the game to its default state
    public void restartGame(){
        if(game != null && game.isAlive()) {
            game.interrupt();
            gameRunning = false;
        }
        if(player != null && player.getStatus() == Player.DEAD){
            gameRunning = false;
        }
        score = 0;
        highScore = getHighScore();
        saveScoreButton.setVisible(false);
        restartButton.setVisible(false);
        playerName = "Player";
        ground = new Ground();
        player = new Player(ground);
        obstacles = new Obstacles(ground);
        GameController controller = new GameController(this);
        game = new Thread(controller);
        walkingSound.stop();
        jumpSound.stop();
        deathSound.stop();
        repaint();
    }

    //updates the information of all components
    public void updateGame(){
        player.update(walkingSound);
        obstacles.update();
        ground.update();
    }

    //ends the game and displays the according buttons
    public void endGame(boolean sound){
        getPlayer().setStatus(Player.DEAD);
        walkingSound.stop();
        jumpSound.stop();
        deathSound.stop();
        if (sound) {
            deathSound.setMicrosecondPosition(0);
            deathSound.start();
        }
        if(isHighScore()){
            saveScoreButton.setVisible(true);
        }
        restartButton.setVisible(true);
    }

    //checks if current score is a new high score
    public boolean isHighScore() {
        try {
            BufferedReader file = new BufferedReader(new FileReader("scores.txt"));
            String[] names = file.lines().toArray(String[]::new);
            if(names.length < 10){
                return true;
            }
            names = Arrays.stream(names)
                    .filter(e -> Integer.parseInt(e.split(" ")[e.split(" ").length - 1]) < score)
                    .toArray(String[]::new);
            file.close();
            if(names.length > 0){
                return true;
            }
        } catch (IOException e) {
            return true;
        }
        return false;
    }

    //updates the high scores list
    public void saveScore(String playerName){
        if(!playerName.isEmpty()) {
            this.playerName = playerName;
        }
        saveScore();
    }
    public void saveScore(){
        String[] scores;
        try {
            BufferedReader file = new BufferedReader(new FileReader("scores.txt"));
            scores = file.lines().toArray(String[]::new);
            file.close();
        } catch (IOException ignored) {
            scores = null;
        }

        try {
            BufferedWriter file = writeScores(scores);
            file.close();
        } catch (IOException ignored) {
            System.out.println("Couldn't open output file(\"scores.txt\") in " + getClass().getSimpleName());
            System.exit(3);
        }
    }

    private BufferedWriter writeScores(String[] scores) throws IOException {
        BufferedWriter file = new BufferedWriter(new FileWriter("scores.txt"));
        int i = 0;
        if(scores !=null) {
            while(i < scores.length && Integer
                    .parseInt(scores[i].split(" ")[scores[i].split(" ").length - 1]) >= score){
                file.write(scores[i] + "\n");
                i++;
            }
            file.write(playerName + " " + score + "\n");
            while(i< scores.length && i < 9){
                file.write(scores[i] + "\n");
                i++;
            }
        }
        else{
            file.write(playerName + " " + score + "\n");
        }
        return file;
    }

    public JButton getMenuButton() {
        return menuButton;
    }

    public JButton getSaveScoreButton() {
        return saveScoreButton;
    }

    public JButton getExitButton() {
        return exitButton;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    //high score is stored in "scores.txt"
    public int getHighScore() {
        if(highScore != 0){
            return highScore;
        }
        try {
            BufferedReader scores = new BufferedReader(new FileReader("scores.txt"));
            String topScorer = scores.readLine();
            if(topScorer != null) {
                String[] topScorerInfo = topScorer.split(" ");
                highScore = Integer.parseInt(topScorerInfo[topScorerInfo.length - 1]);
                scores.close();
            }
        } catch (IOException ignored) {}
        return highScore;
    }

    public void setHighScore(int highScore) {
        this.highScore = highScore;
    }

    public Player getPlayer(){
        return player;
    }

    public Obstacles getObstacles() {
        return obstacles;
    }
}
