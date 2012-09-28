import wot.VehicleMarkersManager.AbstractAccessProxy;
import wot.VehicleMarkersManager.ColorsManager;
import wot.VehicleMarkersManager.Xvm;

class wot.VehicleMarkersManager.components.DamageTextProxy extends AbstractAccessProxy
{
   /**
    * This proxy class is only for access restriction to wot.VehicleMarkersManager.Xvm
    */

    public function DamageTextProxy(xvm:Xvm)
    {
        super(xvm);
    }

    public function createHolder():MovieClip
    {
        return xvm.proxy.createEmptyMovieClip("xvm_damageHolder", xvm.proxy.getNextHighestDepth());
    }

    public function get entityName():String
    {
        return xvm.m_entityName;
    }

    public function get isColorBlindMode():Boolean
    {
        return ColorsManager.isColorBlindMode;
    }
}
