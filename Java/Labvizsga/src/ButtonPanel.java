import javax.swing.JButton;
import javax.swing.JPanel;
import java.awt.GridLayout;
import java.util.ArrayList;

public class ButtonPanel extends JPanel {
    private final ArrayList<Integer> numbers = new ArrayList<>();

    public ButtonPanel(){
        setLayout(new GridLayout(1, 10));
        JButton[] buttons = new JButton[10];
        for(int i = 0; i < 10; i++){
            buttons[i] = new JButton(String.valueOf(i));
            int tmp = i;
            buttons[i].addActionListener(e -> numbers.add(tmp));
            add(buttons[i]);
        }
    }

    public ArrayList<Integer> getNumbers() {
        return numbers;
    }
}
