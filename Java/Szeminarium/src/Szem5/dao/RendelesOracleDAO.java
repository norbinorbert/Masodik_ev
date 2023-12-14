package dao;

public class RendelesOracleDAO implements RendelesDAO{
    @Override
    public String getOsszes() {
        return "Lekertuk az osszes rendelest Oracle adatbazisban";
    }

    @Override
    public String getRendeles(int ID) {
        return "Lekertuk a(z)" + ID + " rendelest (Oracle)";
    }
}
