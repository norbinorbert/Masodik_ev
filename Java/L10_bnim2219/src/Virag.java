import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

//Boda Norbert, 521
public class Virag {
    private int meret;
    private int max_meret;
    private BufferedImage img;
    public Virag(int meret, int max_meret){
        this.meret = meret;
        this.max_meret = max_meret;
        try {
            img = ImageIO.read(new File("img/virag.png"));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public int getMeret() {
        return meret;
    }

    public void setMeret(int meret) {
        this.meret = meret;
    }

    public int getMax_meret() {
        return max_meret;
    }

    public void setMax_meret(int max_meret) {
        this.max_meret = max_meret;
    }

    public BufferedImage getImg() {
        return img;
    }

    public void setImg(BufferedImage img) {
        this.img = img;
    }
}
