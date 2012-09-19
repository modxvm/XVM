import wot.VehicleMarkersManager.Xvm;

class wot.VehicleMarkersManager.AbstractAccessProxy
{
   /* This is abstract proxy class for
    * access control and restriction
    * to wot.VehicleMarkersManager.XVM data
    */
   
    private var xvm:Xvm;

    public function AbstractAccessProxy(xvm:Xvm) 
    {
        this.xvm = xvm;
    }

    public function get currentStateConfigRoot():Object
    {
        return xvm.vehicleState.getCurrentStateConfigRoot();
    }
    
    public function formatDynamicColor(format:String):Number
    {
        return xvm.formatDynamicColor(format, xvm.m_curHealth);
    }

    public function formatStaticColorText(format:String):String
    {
        return xvm.formatStaticColorText(format, xvm.m_curHealth);
    }

    public function formatDynamicAlpha(format:String):Number
    {
        return xvm.formatDynamicAlpha(format, xvm.m_curHealth);
    }
}
