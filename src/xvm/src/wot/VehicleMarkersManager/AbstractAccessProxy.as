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
        return xvm.vehicleState.getCurrentConfig();
    }

    public function formatStaticText(format:String):String
    {
        return xvm.formatStaticText(format);
    }

    public function formatDynamicText(format:String, curHealth:Number, delta:Number, damageType:String):String
    {
        return xvm.formatDynamicText(format, curHealth, delta, damageType);
    }

    public function formatDynamicColor(format:String, damageType:String):Number
    {
        return xvm.formatDynamicColor(format, xvm.m_curHealth, damageType);
    }

    public function formatStaticColorText(format:String):String
    {
        return xvm.formatStaticColorText(format);
    }

    public function formatDynamicAlpha(format:String):Number
    {
        return xvm.formatDynamicAlpha(format, xvm.m_curHealth);
    }
}
