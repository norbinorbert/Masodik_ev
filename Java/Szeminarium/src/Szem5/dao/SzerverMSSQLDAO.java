package dao;

public class SzerverMSSQLDAO implements SzerverDAO{
    @Override
    public void addMegrendeles(String s) {
        System.out.println("Hozzaadtuk (MSSQL): " + s);
    }

    @Override
    public String getSzerverRendeles(String szerver) {
        return "a " + szerver + " tartozo rendelesek (MSSQL)";
    }
}
