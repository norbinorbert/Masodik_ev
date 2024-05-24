import javax.swing.*;
import java.awt.*;

public class AngledThrow extends JFrame {

    private final JButton startAnimation = new JButton("Start");
    private final JButton restartAnimation = new JButton("Restart");
    private final JSlider angleSlider = new JSlider();
    private final JLabel angleLabel = new JLabel();
    private final JSlider speedSlider = new JSlider();
    private final JLabel speedLabel = new JLabel();
    private final AnimationPanel animationPanel = new AnimationPanel(this);

    private double angle;
    private double speed;

    public AngledThrow() {
        setTitle("Angled throw");
        setBounds(100, 100, 800, 600);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        startAnimation.addActionListener(e -> {
            start();
        });

        restartAnimation.addActionListener(e -> {
            restart();
        });

        angleSlider.setMaximum(90);
        angleSlider.setValue(45);
        angle = (double) angleSlider.getValue() / angleSlider.getMaximum() * Math.PI / 2;
        angleLabel.setText("Angle: " + angleSlider.getValue() + "°");
        angleSlider.addChangeListener(event -> {
            angleLabel.setText("Angle: " + angleSlider.getValue() + "°");
            angle = (double) angleSlider.getValue() / angleSlider.getMaximum() * Math.PI / 2;
        });

        speedSlider.setValue(50);
        speed = speedSlider.getValue();
        speedLabel.setText("Speed: " + speed + " m/s");
        speedSlider.addChangeListener(event -> {
            speed = speedSlider.getValue();
            speedLabel.setText("Speed: " + speed + " m/s");
        });

        JPanel topPanel = new JPanel();
        topPanel.setLayout(new FlowLayout());
        topPanel.add(startAnimation);
        topPanel.add(restartAnimation);
        topPanel.add(angleSlider);
        topPanel.add(angleLabel);
        topPanel.add(speedSlider);
        topPanel.add(speedLabel);
        add(topPanel, BorderLayout.NORTH);
        add(animationPanel, BorderLayout.CENTER);

        setVisible(true);
    }

    private void start() {
        startAnimation.setVisible(false);
        angleSlider.setVisible(false);
        speedSlider.setVisible(false);
        restartAnimation.setVisible(false);

        animationPanel.setAngle(angle);
        animationPanel.setSpeed(speed);
        new Thread(animationPanel).start();
    }

    private void restart(){
        startAnimation.setVisible(true);
        angleSlider.setVisible(true);
        speedSlider.setVisible(true);

        animationPanel.reset();
    }

    public JButton getRestartAnimation() {
        return restartAnimation;
    }

    public static void main(String[] args) {
        new AngledThrow();
    }
}