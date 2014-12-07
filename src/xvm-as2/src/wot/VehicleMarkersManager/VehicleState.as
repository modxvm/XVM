/**
 * XVM
 * @author Maxim Schedriviy <m.schedriviy(at)gmail.com>
 */
import com.xvm.Config;
import wot.VehicleMarkersManager.VehicleStateProxy;

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

    public function getCurrentState(): String
    {
        var result:String = proxy.team + "/";
        result += proxy.isDead ? "dead/" : "alive/";
        result += proxy.showExInfo ? "extended" : "normal";
        return result;
    }

    public function getCurrentConfig()
    {
        var result = Config.config.markers;
        result = proxy.team == "ally" ? result.ally : result.enemy;
        result = proxy.isDead ? result.dead : result.alive;
        result = proxy.showExInfo ? result.extended : result.normal;
        return result;
    }

    public function getConfig(stateString: String)
    {
        var path: Array = stateString.split("/");
        if (path.length != 3)
            return null;
        var result = Config.config.markers;
        result = path[0] == "ally" ? result.ally : result.enemy;
        result = path[1] == "alive" ? result.alive : result.dead;
        result = path[2] == "normal" ? result.normal : result.extended;
        return result;
    }

    public function getAllStates()
    {
        return (proxy.team == "enemy") ? allEnemy : allAlly;
    }
}
