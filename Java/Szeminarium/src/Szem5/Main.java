import factory.DAOGyar;
import factory.DAOGyarMSSQL;
import factory.DAOGyarOracle;

public class Main {
    public static void main(String[] args){
        DAOGyar a = new DAOGyarMSSQL();
        DAOGyar b = new DAOGyarOracle();
        DataAccessLayer DAL = new DataAccessLayer();
        DAL.accessDatabase(a);
        DAL.accessDatabase(b);
    }
}
