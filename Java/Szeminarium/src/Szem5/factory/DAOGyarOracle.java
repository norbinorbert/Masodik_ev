package factory;

import dao.*;

public class DAOGyarOracle implements DAOGyar{
    @Override
    public SzerverDAO getSzerverDAO() {
        return new SzerverOracleDAO();
    }

    @Override
    public RendelesDAO getRendelesDAO() {
        return new RendelesOracleDAO();
    }
}
