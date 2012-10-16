package preview
{

import preview.*;

public class ClanIconProxy extends AbstractAccessProxy
{
   /**
    * This proxy class is only for access restriction to wot.VehicleMarkersManager.Xvm
    */

    public function ClanIconProxy(xvm:Xvm)
    {
        super(xvm);
    }

    public function get playerName():String
    {
        return xvm.m_playerFullName;
    }
}

}
