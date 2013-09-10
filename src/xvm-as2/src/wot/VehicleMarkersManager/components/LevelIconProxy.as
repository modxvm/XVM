import wot.VehicleMarkersManager.AbstractAccessProxy;
import wot.VehicleMarkersManager.Xvm;

class wot.VehicleMarkersManager.components.LevelIconProxy extends AbstractAccessProxy
{
   /**
    * This proxy class is only for access restriction to wot.VehicleMarkersManager.Xvm
    */

    public function LevelIconProxy(xvm:Xvm)
    {
        super(xvm);
    }

    public function get levelIcon():MovieClip
    {
        return xvm.wrapper.levelIcon;
    }

    public function get level():Number
    {
        return xvm.m_level;
    }
}
