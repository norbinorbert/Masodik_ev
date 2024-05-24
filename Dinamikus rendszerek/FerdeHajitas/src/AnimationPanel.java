import javax.swing.*;
import java.awt.*;
import java.util.ArrayList;

/*
    x'(t) = v(t)
    v'(t) = 0
    x(0) = x0
    v(0) = v0 * cos(angle)

    y'(t) = v(t)
    v'(t) = -g
    y(0) = y0
    v(0) = v0 * sin(angle)
*/

public class AnimationPanel extends JPanel implements Runnable {
    private static final double x0 = 20;
    private static final double y0 = 20;
    private static final int numberOfIterations = 20;
    private final ArrayList<Point> points = new ArrayList<>();
    private double angle;
    private double speed;
    private final AngledThrow parent;

    public AnimationPanel(AngledThrow parent){
        this.parent = parent;
    }

    @Override
    public void run() {
        points.clear();
        double x = x0, y = y0;
        double vx = speed * Math.cos(angle);
        double vy = speed * Math.sin(angle);
        double g = 9.8;
        for (int i = 0; i < numberOfIterations; i++) {
            points.add(new Point((int) x, (int) y));
            x += vx;
            y += vy;
            vy -= g;
            try {
                Thread.sleep(100);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
            repaint();
        }
        parent.getRestartAnimation().setVisible(true);
    }

    public void reset() {
        points.clear();
        repaint();
    }

    @Override
    public void paintComponent(Graphics g) {
        super.paintComponent(g);
        g.drawLine((int) x0, 0, (int) x0, getHeight());
        g.drawLine(0, getHeight() / 2, getWidth(), getHeight() / 2);
        for(int i=0;i<250;i++) {
            g.fillOval(10 * i, getHeight() / 2 - 2, 4, 4);
            g.fillOval((int) (x0 - 2), 10 * i, 4, 4);
        }
        g.setColor(Color.RED);
        g.fillOval((int) x0 - 3, (int) (-y0 + (double) getHeight() / 2) - 3, 6, 6);
        for (int i = 0; i < points.size() - 1; i++) {
            g.setColor(Color.RED);
            g.drawLine(points.get(i).x, -points.get(i).y + getHeight() / 2,
                    points.get(i + 1).x, -points.get(i + 1).y + getHeight() / 2);
        }
    }

    public void setAngle(double angle) {
        this.angle = angle;
    }

    public void setSpeed(double speed) {
        this.speed = speed;
    }
}
