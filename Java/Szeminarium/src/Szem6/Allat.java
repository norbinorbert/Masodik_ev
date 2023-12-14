import java.util.Arrays;

public class Allat {
    private String faj;
    private int eletkor;
    private double[] meresek;

    public Allat(String faj, int eletkor, double[] meresek) {
        this.faj = faj;
        this.eletkor = eletkor;
        this.meresek = meresek;
    }

    public String getFaj() {
        return faj;
    }

    public void setFaj(String faj) {
        this.faj = faj;
    }

    public int getEletkor() {
        return eletkor;
    }

    public void setEletkor(int eletkor) {
        this.eletkor = eletkor;
    }

    public double[] getMeresek() {
        return meresek;
    }

    public void setMeresek(double[] meresek) {
        this.meresek = meresek;
    }

    @Override
    public String toString() {
        return faj + " " + eletkor;
    }
}
