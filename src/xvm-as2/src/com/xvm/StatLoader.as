import flash.external.*;
import com.xvm.*;
import com.xvm.DataTypes.*;

class com.xvm.StatLoader
{
    private static var _instance:StatLoader = null
    public static function get instance():StatLoader
    {
        if (_instance == null)
            _instance = new StatLoader();
        return _instance;
    }

    public static function LoadData()
    {
        if (Stat.s_loaded == true)
            return;
        if (instance._loading)
            return;
        instance._loading = true;
        Stat.s_data = {};
        Cmd.loadBattleStat(null);
    }

    // PRIVATE

    private var _loading = false;

    private function StatLoader()
    {
        ExternalInterface.addCallback(Cmd.RESPOND_BATTLE_STAT_DATA, this, LoadStatDataCallback);
    }

    private function LoadStatDataCallback(json_str)
    {
        var finallyBugWorkaround: Boolean = false; // Workaround: finally block have a bug - it can be called twice. Why? How?
        try
        {
            var response = JSONx.parse(json_str);
            //Logger.addObject(response, 2, "response");

            if (response.players)
            {
                for (var nm in response.players)
                {
                    var stat:StatData = response.players[nm];
                    //Logger.addObject(stat);
                    CalculateStatValues(stat);
                    if (!Stat.s_data[nm])
                    {
                        //players_count++;
                        Stat.s_data[nm] = { };
                    }
                    Stat.s_data[nm].stat = stat;
                    Stat.s_data[nm].loadstate = (Stat.s_data[nm].vehicleKey == "UNKNOWN")
                        ? Defines.LOADSTATE_UNKNOWN : Defines.LOADSTATE_DONE;
                    Macros.RegisterStatMacros(nm, stat);
                    //Logger.addObject(Stat.s_data[nm], 2, "s_data[" + nm + "]");
                }
            }
        }
        catch (ex)
        {
            Logger.add("[LoadStatDataCallback] ERROR: " + Utils.parseError(ex));
        }
        finally
        {
            if (finallyBugWorkaround)
                return;
            finallyBugWorkaround = true;

            Stat.s_loaded = true;
            _loading = false;
            //Logger.add("Stat Loaded");
            GlobalEventDispatcher.dispatchEvent({type: Defines.E_STAT_LOADED});
        }
    }

    // TODO: remove
    public function CalculateStatValues(stat:StatData):Void
    {
        stat.v.data = VehicleInfo.get(stat.v.id);
    }
}
