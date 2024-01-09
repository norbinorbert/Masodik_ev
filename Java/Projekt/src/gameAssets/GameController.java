package gameAssets;

import panels.GamePanel;
//Boda Norbert, 521

public class GameController implements Runnable{
    private final GamePanel view;

    public GameController(GamePanel view){
        this.view = view;
    }

    //updates the game score, player status and obstacle status while running
    @Override
    public void run() {
        while (view.getPlayer().getStatus() != Player.DEAD) {
            view.updateGame();
            view.repaint();

            for(Obstacle obstacle : view.getObstacles().getObstacles()){
                if(view.getPlayer().getRectangle().intersects(obstacle.getHitbox())){
                    view.endGame(GamePanel.END_GAME_WITH_DEATH_SOUND);
                }
                if(obstacle.givesPoint() && view.getPlayer().getTopX() >= obstacle.getHitbox().x){
                    int score = view.getScore() + 1;
                    view.setScore(score);
                    if(view.getHighScore() < score){
                        view.setHighScore(score);
                    }
                    obstacle.invalidate();
                }
            }
            try {
                Thread.sleep(50);
            } catch (InterruptedException ignored) {
                return;
            }
        }
    }
}
