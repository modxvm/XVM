/**
 * @author ilitvinov87@gmail.com
 */
import com.xvm.Logger;

class wot.VehicleMarkersManager.log.HpLog
{
    private var cfg:Object;
    
    public function HpLog(cfg:Object) 
    {
        this.cfg = cfg;
    }
    
    public function onNewMarkerCreated(vClass:String, vIconSource:String, vType:String,
                                       vLevel:Number, pFullName:String,
                                       curHealth:Number, maxHealth:Number):Void
    {
        //Logger.add("onNewMarkerCreated " + vType);
    }
   
    public function onHealthUpdate(pFullName:String, curHealthAbsolute:Number):Void
    {
        //Logger.add("onHealthUpdate " + curHealthAbsolute);
    }
}
