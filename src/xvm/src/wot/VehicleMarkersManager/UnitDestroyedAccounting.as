import com.xvm.Logger;

/**
 * Logs when ally or enemy unit is killed with timestamps.
 * 
 * This information is needed for Hitlog to define
 * if player is shooting at is drowned player.
 * Logic is: if unit has died some time ago but is still damageable
 * then this player is drowned and inflicted damage should not be taken into account.
 * 
 * @author ilitvinov87@gmail.com
 */
class wot.VehicleMarkersManager.UnitDestroyedAccounting
{
    private static var _instance:UnitDestroyedAccounting;
    
    private var logs:Array = [];
    
    public static function get instance():UnitDestroyedAccounting
    {
        if (!_instance)
        {
            _instance = new UnitDestroyedAccounting();
        }
        
        return _instance;
    }
    
    public function logDead(name:String):Void
    {
        checkNameArg(name, "logDead");
        
        /**
         * New logs should not overwrite old ones.
         * Hitlog drowned unit recognition relies on this.
         * 
         * This method could be invoked by updateHealth
         * even if subject is already dead.
         * This is the case drowned unit damage.
         * 
         * Or on final blow.
         */
        if (!getStatus(name))
        {
            var status:Object = { name: name, timestamp: currentTime };
            logs.push(status);
        }
    }
    
    public function diedSomeTimeAgo(name:String):Boolean
    {
        checkNameArg(name, "diedSomeTimeAgo");
        
        var status:Object = getStatus(name);
        
        if (status == null)
        {
            /**
             * The guy is still alive
             * or final blow.
             */
            return false;
        }
        
        return status.timestamp < currentTime;
    }
    
    //-- Private
    
    private function getStatus(name:String):Object
    {
        for (var i in logs)
        {
            var status:Object = logs[i];
            
            if (status.name == name)
            {
                return status;
            }
        }
        
        return null;
    }
    
    private function get currentTime():Number
    {
        /** Fri Jan 22 13:01:55 GMT+0530 2010 */
        var myDate:Date = new Date();
        
        /** Unix Time: 1264145516 */
        var unixTime:Number = Math.round(myDate.getTime() / 1000);
        
        return unixTime;
    }
    
    
    private function checkNameArg(name:String, funcname:String):Void
    {
        if (name == null)
        {
            Logger.add("ERROR: wot.VehicleMarkersManager.UnitDestroyedAccounting: name == null for: " + funcname);
        }
    }
}
