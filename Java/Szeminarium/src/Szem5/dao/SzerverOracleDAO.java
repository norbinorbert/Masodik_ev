package dao;

public class SzerverOracleDAO implements SzerverDAO{
    @Override
    public void addMegrendeles(String s) {
        System.out.println("Hozzaadtuk (Oracle): " + s);
    }

    @Override
    public String getSzerverRendeles(String szerver) {
        return "a " + szerver + " tartozo rendelesek (Oracle)";
    }
}
