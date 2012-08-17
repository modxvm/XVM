import wot.VehicleMarkersManager.XVM;
class wot.VehicleMarkersManager.AbstractAccessProxy
{
   /* This is abstract proxy class for
    * access control and restriction
    * to wot.VehicleMarkersManager.XVM data
    */
   
    var xvm:XVM;

    public function AbstractAccessProxy(xvm:XVM) 
    {
        this.xvm = xvm;
    }
}