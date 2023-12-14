import dao.RendelesDAO;
import dao.SzerverDAO;
import factory.DAOGyar;
import factory.DAOGyarMSSQL;
import factory.DAOGyarOracle;

import javax.xml.crypto.Data;

public class DataAccessLayer {
    private RendelesDAO r;
    private SzerverDAO sz;
    public void accessDatabase(DAOGyar a){
        r = a.getRendelesDAO();
        sz = a.getSzerverDAO();
        System.out.println(r.getOsszes());
        System.out.println(r.getRendeles(3));
        sz.addMegrendeles("asd");
        System.out.println(sz.getSzerverRendeles("asd"));
    }
}
