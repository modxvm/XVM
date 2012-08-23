import wot.VehicleMarkersManager.AbstractAccessProxy;
import wot.VehicleMarkersManager.XVM;

class wot.VehicleMarkersManager.LevelIconProxy extends AbstractAccessProxy
{
   /* This proxy class is only for LevelIconComponent
    * access restriction to wot.VehicleMarkersManager.XVM
    */
   
    public function LevelIconProxy(xvm:XVM) 
    {
        super(xvm);
    }
    
    public function get levelIcon():MovieClip
    {
        return xvm.levelIcon;
    }
    
    public function get level():Number
    {
        return xvm["m_level"]; // FIXIT
    }
    
    public function XVMFormatDynamicAlpha(format: String): Number
    {
        return xvm.XVMFormatDynamicAlpha(format, xvm["m_curHealth"]); // FIXIT
    }
}