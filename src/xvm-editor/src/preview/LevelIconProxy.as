package preview
{

import flash.display.MovieClip;
import preview.*;

public class LevelIconProxy extends AbstractAccessProxy
{
   /**
    * This proxy class is only for access restriction to wot.VehicleMarkersManager.Xvm
    */

    public function LevelIconProxy(xvm:preview.Xvm)
    {
        super(xvm);
    }

    public function get levelIcon():MovieClip
    {
        return xvm.proxy.levelIcon;
    }

    public function get level():Number
    {
        return xvm.m_level;
    }
}

}
