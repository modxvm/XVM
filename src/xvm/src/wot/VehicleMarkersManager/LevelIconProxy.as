import wot.VehicleMarkersManager.XVM;

class wot.VehicleMarkersManager.LevelIconProxy
{
   /* This proxy class is only for LevelIconComponent
    * access restriction to wot.VehicleMarkersManager.XVM
    */
   
    var xvm:XVM;
    
    public function LevelIconProxy(xvm:XVM) 
    {
        this.xvm = xvm;
    }
    
    public function get levelIcon():MovieClip
    {
        return xvm.levelIcon;
    }
    
    public function get level():Number
    {
        return xvm.m_level;
    }
    
    public function XVMFormatDynamicAlpha(format: String): Number
    {
        return xvm.XVMFormatDynamicAlpha(format, xvm.m_curHealth);
    }
}