/**
 * ...
 * @author 
 */
class wot.VehicleMarkersManager.log.HpLogView
{
    private var cfg:Object;
    
    public function HpLogView(cfg:Object) 
    {
        this.cfg = cfg;
        
        // Build
    }
    
    public function update(model:Object) 
    {
        /**
         * VVM's separate sandbox can know about death
         * event only inside markers draw area.
         */
    }
}
