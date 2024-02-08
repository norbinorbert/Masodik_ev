import java.util.ArrayList;
import java.util.Random;

public class GameController implements Runnable{
    private final Game game;
    private final int n;
    private int time;
    private final Random r = new Random();
    private final int[] numbers = new int[4];

    public GameController(Game game, int n){
        this.game = game;
        this.n = n;
        time = 4000;
    }

    @Override
    public void run() {
        for(int i = 0; i < n; i++){
            StringBuilder text = new StringBuilder();
            for(int j = 0; j < 4; j++){
                numbers[j] = r.nextInt(10);
                text.append(numbers[j]).append(", ");
            }
            text.delete(text.length()-2, text.length());

            game.getNorthLabel().setText(text.toString());
            game.getSouthLabel().setText(String.valueOf(n-i));
            game.repaint();

            try {
                Thread.sleep(time);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }

            ArrayList<Integer> clickedNumbers = game.getButtonPanel().getNumbers();
            if(clickedNumbers.size() != 4){
                game.endGame(Game.LOSE);
                return;
            }
            for(int j = 0; j < 4; j++){
                if(clickedNumbers.get(j) != numbers[j]){
                    game.endGame(Game.LOSE);
                    return;
                }
            }
            game.getButtonPanel().getNumbers().clear();
            time -= 200;
        }
        game.getSouthLabel().setText("0");
        game.repaint();
        game.endGame(Game.WIN);
    }

}
