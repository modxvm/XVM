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
        Stat.s_empty = true;
        Cmd.loadBattleStat(null);
    }

    // PRIVATE

    private var _loading = false;

    private function StatLoader()
    {
        ExternalInterface.addCallback(Cmd.RESPOND_BATTLEDATA, this, LoadStatDataCallback);
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
                    Stat.s_empty = false;
                    Macros.RegisterStatMacros(nm, stat);
                    //Logger.addObject(StatData.s_data[nm], "s_data[" + nm + "]", 3);
                }
                Macros.RegisterBattleTierData(guessBattleTier());
            }
        }
        catch (ex)
        {
            Logger.add("[LoadStatDataCallback] ERROR: " + ex.toString());
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

    public function CalculateStatValues(stat:StatData, forceTeff:Boolean):Void
    {
        // rating (GWR)
        stat.r = stat.b > 0 ? stat.w / stat.b * 100 : NaN;

        if (stat.v == null)
        {
            stat.v = new VData();
            return;
        }

        stat.v.data = VehicleInfo.get(stat.v.id);
        if (stat.v.data == null)
        {
            //Logger.add("WARNING: vehicle info (3) missed: " + stat.vn);
            return;
        }

        var vdata:VehicleData = stat.v.data;

        if (stat.v.b == null || stat.v.b <= 0)
            stat.v.r = stat.r;
        else
        {
            var Or = stat.r;
            var Tr = stat.v.w / stat.v.b * 100;
            var Tb = stat.v.b / 100;
            var Tl = Math.min(vdata.level, 4) / 4;
            if (stat.v.b < 100)
                stat.v.r = Or - (Or - Tr) * Tb * Tl;
            else
                stat.v.r = Tr;
        }

        // XVM Scale: http://www.koreanrandom.com/forum/topic/2625-xvm-scale

        // xeff
        stat.xeff = null;
        if (stat.e != null && stat.e > 0)
            stat.xeff = Utils.XEFF(stat.e);

        // xwn6
        stat.xwn6 = null;
        if (stat.wn6 != null && stat.wn6 > 0)
            stat.xwn6 = Utils.XWN6(stat.wn6);

        // xwn8
        stat.xwn8 = null;
        if (stat.wn8 != null && stat.wn8 > 0)
            stat.xwn8 = Utils.XWN8(stat.wn8);

        // tdb, tfb, tsb, tdv, te, teff (last)
        stat.v.db = null;
        stat.v.fb = null;
        stat.v.sb = null;
        stat.v.dv = null;
        stat.v.te = null;
        stat.v.teff = null;
        // skip v.b less then 10, because of WG bug:
        // http://www.koreanrandom.com/forum/topic/1643-/page-19#entry26189
        // forceTeff used in UserInfo, there is not this bug there.
        if (stat.v.b == null || (forceTeff != true && stat.v.b < 10 + vdata.level * 2))
            return;

        stat.v.db = (stat.v.dmg == null || stat.v.dmg < 0) ? null : stat.v.dmg / stat.v.b;
        stat.v.fb = (stat.v.frg == null || stat.v.frg < 0) ? null : stat.v.frg / stat.v.b;
        stat.v.sb = (stat.v.spo == null || stat.v.spo < 0) ? null : stat.v.spo / stat.v.b;
        //Logger.addObject(stat.v, 1, stat.name);

        stat.v.dv = (stat.v.dmg == null || stat.v.dmg < 0) ? null : stat.v.dmg / stat.v.b / vdata.hpTop;

        var EC = { CD: 3, CF: 1 };
        //Logger.addObject(stat);
//        Logger.addObject(EC);
        if (EC.CD != null && EC.CD > 0 && (stat.v.db == null || stat.v.db <= 0))
            return;
        if (EC.CF != null && EC.CF > 0 && (stat.v.fb == null || stat.v.fb <= 0))
            return;

        if (vdata.top.D == vdata.avg.D || vdata.top.F == vdata.avg.F)
            return;

        var dD = stat.v.db - vdata.avg.D;
        var dF = stat.v.fb - vdata.avg.F;
        var minD = vdata.avg.D * 0.4;
        var minF = vdata.avg.F * 0.4;
        var d = 1 + dD / (vdata.top.D - vdata.avg.D);
        var f = 1 + dF / (vdata.top.F - vdata.avg.F);
        var d2 = (stat.v.db < vdata.avg.D) ? stat.v.db / vdata.avg.D : d;
        var f2 = (stat.v.fb < vdata.avg.F) ? stat.v.fb / vdata.avg.F : f;
        d = (stat.v.db < vdata.avg.D) ? 1 + dD / (vdata.avg.D - minD) : d;
        f = (stat.v.fb < vdata.avg.F) ? 1 + dF / (vdata.avg.F - minF) : f;

        d = Math.max(0, d);
        f = Math.max(0, f);
        d2 = Math.max(0, d2);
        f2 = Math.max(0, f2);

        stat.v.te = (d * EC.CD + f * EC.CF) / (EC.CD + EC.CF);
        //stat.teff2 = (d2 * EC.CD + f2 * EC.CF) / (EC.CD + EC.CF);
        //Logger.add(stat.v.data.shortName + " D:" + d + " F:" + f);

        stat.v.teff = Math.max(1, stat.v.te * 1000);
        //stat.teff2 = Math.max(1, stat.teff2 * 1000);
        stat.v.te = (stat.v.teff == 0) ? 0 //can not be used
            : (stat.v.teff < 300) ? 1
            : (stat.v.teff < 500) ? 2
            : (stat.v.teff < 700) ? 3
            : (stat.v.teff < 900) ? 4
            : (stat.v.teff < 1100) ? 5
            : (stat.v.teff < 1300) ? 6
            : (stat.v.teff < 1550) ? 7
            : (stat.v.teff < 1800) ? 8
            : (stat.v.teff < 2000) ? 9 : 10;

        //Logger.add(stat.v.data.shortName + " teff=" + stat.v.teff + " e:" + stat.v.te);
//        Logger.addObject(stat);
    }

    private function guessBattleTier():Number
    {
        // 1. Collect all vehicles info
        var vis: Array = [];
        for (var pname:String in Stat.s_data)
        {
            var stat:StatData = Stat.s_data[pname].stat;
            var vdata:VehicleData = stat.v.data;
            if (vdata == null || vdata.key == "ussr:Observer")
                continue;
            vis.push( {
                level: vdata.level,
                Tmin: vdata.tierLo,
                Tmax: vdata.tierHi
            });
        }

        // 2. Sort vehicles info by top tiers descending
        vis.sortOn("Tmax", Array.NUMERIC | Array.DESCENDING);

        // 3. Find minimum Tmax and maximum Tmin
        var Tmin = vis[0].Tmin;
        var Tmax = vis[0].Tmax;
        //Logger.add("T before=" + Tmin + ".." + Tmax);
        var vis_length = vis.length;
        for (var i = 1; i < vis_length; ++i)
        {
            var vi = vis[i];
            //Logger.add("l=" + vi.level + " Tmin=" + vi.Tmin + " Tmax=" + vi.Tmax);
            if (vi.Tmax < Tmin) // Skip "trinkets"
                continue;
            if (vi.Tmin > Tmin)
                Tmin = vi.Tmin;
            if (vi.Tmax < Tmax)
                Tmax = vi.Tmax;
        }
        //Logger.add("T after=" + Tmin + ".." + Tmax);

        // 4. Return battle tier
        return (Tmax > 10) ? Tmax : Tmin;
    }
}
