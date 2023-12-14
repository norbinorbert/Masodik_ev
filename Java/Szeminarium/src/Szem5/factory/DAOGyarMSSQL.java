package factory;
import dao.*;
public class DAOGyarMSSQL implements DAOGyar{
    @Override
    public SzerverDAO getSzerverDAO() {
        return new SzerverMSSQLDAO();
    }

    @Override
    public RendelesDAO getRendelesDAO() {
        return new RendelesMSSQLDAO();
    }
}
