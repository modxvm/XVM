import wot.utils.Config;
import wot.VehicleMarkersManager.VehicleStateProxy;
import wot.utils.Logger;

class wot.VehicleMarkersManager.VehicleState
{
    /* TODO:
     * move isDead showExInfo team etc into this.
    */
    private var proxy:VehicleStateProxy;
    
    public static var allAlly: Array = [
        "ally/alive/normal", "ally/alive/extended", "ally/dead/normal", "ally/dead/extended"]
    public static var allEnemy: Array = [
        "enemy/alive/normal", "enemy/alive/extended", "enemy/dead/normal", "enemy/dead/extended"]
    
    public function VehicleState(proxy:VehicleStateProxy) 
    {
        this.proxy = proxy;
    }
    
    public function getCurrentStateString(): String
    {
        var result:String = proxy.team + "/";
        result += (proxy.vehicleDestroyed || proxy.isDead) ? "dead/" : "alive/";
        result += proxy.showExInfo ? "extended" : "normal";
        return result;
    }

    public function getStateConfigRoot(stateString: String)
    {
        var path: Array = stateString.split("/");
        if (path.length != 3)
            return null;
        var result = Config.s_config.markers;
        result = path[0] == "ally" ? result.ally : result.enemy;
        result = path[1] == "alive" ? result.alive : result.dead;
        result = path[2] == "normal" ? result.normal : result.extended;
        return result;
    }

    public function getCurrentStateConfigRoot()
    {
        //Logger.add( getStateConfigRoot(getCurrentStateString()) );
        return      getStateConfigRoot(getCurrentStateString());
    }

    public function getCurrentStateConfigRootNormal()
    {
        //Logger.add( getStateConfigRoot(getCurrentStateString().split("extended").join("normal")) );
        return      getStateConfigRoot(getCurrentStateString().split("extended").join("normal")) ;
    }
}