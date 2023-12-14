package dao;

public class RendelesMSSQLDAO implements RendelesDAO{
    @Override
    public String getOsszes() {
        return "Lekertuk az osszes rendelest MSSQL adatbazisban";
    }

    @Override
    public String getRendeles(int ID) {
        return "Lekertuk a(z)" + ID + " rendelest (MSSQL)";
    }
}
