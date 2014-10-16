/**
 * XVM Config
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package com.xvm
{
    import com.xvm.*;
    import com.xvm.events.*;
    import com.xvm.io.*;
    import com.xvm.utils.*;
    import com.xvm.types.stat.*;
    import com.xvm.types.veh.*;
    import flash.events.*;
    import flash.external.*;
    import flash.utils.*;

    public class Stat extends EventDispatcher
    {
        public static const COMPLETE_BATTLE:String = "complete_battle";
        public static const COMPLETE_BATTLERESULTS:String = "complete_battleresults";
        public static const COMPLETE_USERDATA:String = "complete_userdata";

        // instance
        private static var _instance:Stat = null;
        public static function get instance():Stat
        {
            if (_instance == null)
                _instance = new Stat();
            return _instance;
        }

        public static function get loaded():Boolean
        {
            return instance.loaded;
        }

        public static function get stat():Dictionary
        {
            return instance.statCache;
        }

        public static function getData(name:String):StatData
        {
            return stat.hasOwnProperty(name) ? stat[name] : null;
        }

        public static function isUserDataCachedByName(name:String):Boolean
        {
            var key:String = Config.gameRegion + "/" + name;
            return instance.userCache.hasOwnProperty(key);
        }

        public static function getUserDataByName(name:String):StatData
        {
            var key:String = Config.gameRegion + "/" + name;
            return instance.userCache.hasOwnProperty(key) ? instance.userCache[key] : null;
        }

        public static function getUserDataById(id:uint):StatData
        {
            var key:String = "ID/" + id.toString();
            return instance.userCache.hasOwnProperty(key) ? instance.userCache[key] : null;
        }

        public static function loadBattleStat(target:Object, callback:Function, force:Boolean = false):void
        {
            instance.loadBattleStat(target, callback, force);
        }

        public static function loadBattleResultsStat(target:Object, callback:Function, arenaUniqueId:String):void
        {
            instance.loadBattleResultsStat(target, callback, arenaUniqueId);
        }

        public static function loadUserData(target:Object, callback:Function, value:String, isId:Boolean):void
        {
            instance.loadUserData(target, callback, value, isId);
        }

        // PRIVATE

        private var statCache:Dictionary;
        private var battleResultsCache:Dictionary;
        private var userCache:Dictionary;
        private var loading:Boolean;
        private var loaded:Boolean;
        private var listenersBattle:Vector.<Object>;
        private var listenersBattleResults:Dictionary;
        private var listenersUser:Dictionary;

        function Stat()
        {
            statCache = new Dictionary();
            battleResultsCache = new Dictionary();
            userCache = new Dictionary();
            loading = false;
            loaded = false;
            listenersBattle = new Vector.<Object>();
            listenersBattleResults = new Dictionary();
            listenersUser = new Dictionary();
            ExternalInterface.addCallback(Cmd.RESPOND_BATTLEDATA, battleLoaded);
            ExternalInterface.addCallback(Cmd.RESPOND_BATTLERESULTSDATA, battleResultsLoaded);
            ExternalInterface.addCallback(Cmd.RESPOND_USERDATA, userLoaded);
        }

        private function loadBattleStat(target:Object, callback:Function, force:Boolean):void
        {
            //Logger.add("TRACE: loadBattleStat(): target=" + String(target));
            try
            {
                if (force)
                {
                    loaded = false;
                    // TODO: what if loading?
                }

                if (loaded)
                {
                    if (callback != null)
                        callback.call(target);
                    return;
                }

                if (callback != null)
                    listenersBattle.push( { target:target, callback:callback } );
                if (loading)
                    return;
                loading = true;

                Cmd.loadBattleStat();
            }
            catch (e:Error)
            {
                Logger.add(e.getStackTrace());
                throw e;
            }
        }

        private function battleLoaded(json_str:String):void
        {
            Logger.add("TRACE: battleLoaded()");

            try
            {
                var response:Object = JSONx.parse(json_str);
                //Logger.addObject(response, 3, "response");

                // clear cache, because it is also used for current battle players list
                statCache = new Dictionary();

                if (response.players)
                {
                    for (var name:String in response.players)
                    {
                        var sd:StatData = ObjectConverter.convertData(response.players[name], StatData);
                        calculateStatValues(sd);
                        stat[name] = sd;
                        // TODO
                        //StatData.s_data[nm].loadstate = (StatData.s_data[nm].vehicleKey == "UNKNOWN")
                        //    ? Defines.LOADSTATE_UNKNOWN : Defines.LOADSTATE_DONE;
                        Macros.RegisterStatMacrosData(name);
                        //Logger.addObject(stat[name], 3, "stat[" + name + "]");
                    }
                    Macros.RegisterBattleTierData(guessBattleTier());
                }
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
                Logger.add(json_str);
                throw ex;
            }
            finally
            {
                loaded = true;
                loading = false;
                //Logger.add("Stat Loaded");

                for each (var l:Object in listenersBattle)
                {
                    try
                    {
                        l.callback.call(l.target);
                    }
                    catch (e:Error)
                    {
                        Logger.add(e.getStackTrace());
                    }
                    catch (e:*)
                    {
                        Logger.addObject(e, 1, "exception");
                    }
                }
                listenersBattle = new Vector.<Object>();

                dispatchEvent(new Event(COMPLETE_BATTLE));
            }

            //Logger.add("TRACE: battleLoaded(): end");
        }

        private function loadBattleResultsStat(target:Object, callback:Function, arenaUniqueId:String):void
        {
            //Logger.add("TRACE: loadBattleResultsStat(): target=" + String(target));
            if (arenaUniqueId == null || arenaUniqueId == "")
            {
                callback.call(target, null);
                return;
            }
            var inProgress:Boolean = false;
            if (callback != null)
            {
                if (battleResultsCache.hasOwnProperty(arenaUniqueId))
                {
                    callback.call(target, battleResultsCache[arenaUniqueId]);
                    return;
                }
                if (!listenersBattleResults.hasOwnProperty(arenaUniqueId))
                    listenersBattleResults[arenaUniqueId] = new Vector.<Object>();
                else
                {
                    for each (var l:Object in listenersBattleResults[arenaUniqueId])
                    {
                        if (l.target == target && l.callback == callback)
                            return;
                    }
                    inProgress = true;
                }
                listenersBattleResults[arenaUniqueId].push({ target:target, callback:callback });
            }

            if (!inProgress)
                Cmd.loadBattleResultsStat(arenaUniqueId);
        }

        private function battleResultsLoaded(json_str:String):void
        {
            //Logger.add("TRACE: battleResultsLoaded()");
            var arenaUniqueId:String = null;
            try
            {
                var response:Object = JSONx.parse(json_str);
                //Logger.addObject(response, 3, "response");

                arenaUniqueId = response.arenaUniqueId;

                battleResultsCache[arenaUniqueId] = response;

                if (response.players)
                {
                    for (var name:String in response.players)
                    {
                        var sd:StatData = ObjectConverter.convertData(response.players[name], StatData);
                        calculateStatValues(sd);
                        statCache[name] = sd;
                        Macros.RegisterStatMacrosData(name);
                    }
                    Macros.RegisterBattleTierData(guessBattleTier());
                }
            }
            catch (e:Error)
            {
                Logger.add(e.getStackTrace());
                throw e;
            }
            finally
            {
                if (arenaUniqueId == null)
                    return;
                try
                {
                    if (listenersBattleResults.hasOwnProperty(arenaUniqueId))
                    {
                        var l:Vector.<Object> = listenersBattleResults[arenaUniqueId];
                        for (var i:Number = 0; i < l.length; ++i)
                        {
                            var o:Object = l[i];
                            o.callback.call(o.target, battleResultsCache[arenaUniqueId]);
                        }
                        delete listenersBattleResults[arenaUniqueId];
                    }
                }
                catch (e:Error)
                {
                    Logger.add(e.getStackTrace());
                }
                dispatchEvent(new ObjectEvent(COMPLETE_BATTLERESULTS, arenaUniqueId));
            }
        }

        private function loadUserData(target:Object, callback:Function, value:String, isId:Boolean):void
        {
            //Logger.add("TRACE: loadUserData(): target=" + String(target));
            try
            {
                if (value == null || value == "")
                {
                    callback.call(target, null);
                    return;
                }
                var inProgress:Boolean = false;
                if (callback != null)
                {
                    var key:String = (isId ? "ID" : Config.gameRegion) + "/" + value;
                    if (userCache.hasOwnProperty(key))
                    {
                        callback.call(target, userCache[key]);
                        return;
                    }
                    if (!listenersUser.hasOwnProperty(key))
                        listenersUser[key] = new Vector.<Object>();
                    else
                    {
                        for each (var l:Object in listenersUser[key])
                        {
                            if (l.target == target && l.callback == callback)
                                return;
                        }
                        inProgress = true;
                    }
                    listenersUser[key].push({ target:target, callback:callback });
                }

                if (!inProgress)
                    Cmd.loadUserData(value, isId);
            }
            catch (e:Error)
            {
                Logger.add(e.getStackTrace());
                throw e;
            }
        }

        private function userLoaded(json_str:String):void
        {
            //Logger.add("TRACE: userLoaded()");
            var name:String = null;
            var key1:String = null;
            var key2:String = null;
            try
            {
                var sd:StatData = ObjectConverter.convertData(JSONx.parse(json_str), StatData);
                calculateStatValues(sd);
                name = sd.name || sd.nm;
                //Logger.addObject(sd, "sd", 2);
                key1 = Config.gameRegion + "/" + name;
                userCache[key1] = sd;
                key2 = "ID/" + sd._id;
                userCache[key2] = sd;
                //Logger.add(key1 + ", " + key2);
            }
            catch (e:Error)
            {
                Logger.add(e.getStackTrace());
                throw e;
            }
            finally
            {
                processUserListener(key1);
                processUserListener(key2);
                dispatchEvent(new ObjectEvent(COMPLETE_USERDATA, name));
            }
        }

        private function processUserListener(key:String):void
        {
            if (key == null)
                return;
            try
            {
                if (listenersUser.hasOwnProperty(key))
                {
                    var l:Vector.<Object> = listenersUser[key];
                    for (var i:Number = 0; i < l.length; ++i)
                    {
                        var o:Object = l[i];
                        o.callback.call(o.target);
                    }
                    delete listenersUser[key];
                }
            }
            catch (e:Error)
            {
                Logger.add(e.getStackTrace());
            }
        }

        public function calculateStatValues(stat:StatData, forceTeff:Boolean = false):void
        {
            // rating (GWR)
            if (!isNaN(stat.b) && !isNaN(stat.w) && stat.b > 0)
                stat.r = stat.w / stat.b * 100;

            // XVM Scale: http://www.koreanrandom.com/forum/topic/2625-xvm-scale

            // xeff
            if (!isNaN(stat.e))
                stat.xeff = XvmScale.XEFF(stat.e);

            // xwn6
            if (!isNaN(stat.wn6))
                stat.xwn6 = XvmScale.XWN6(stat.wn6);

            // xwn8
            if (!isNaN(stat.wn8))
                stat.xwn8 = XvmScale.XWN8(stat.wn8);

            // xwgr
            if (!isNaN(stat.wgr))
                stat.xwgr = XvmScale.XWGR(stat.wgr);

            // vehicle stat
            calculateVehicleStatValues(stat, forceTeff);
        }

        // tdb, tfb, tsb, tdv, te, teff
        public function calculateVehicleStatValues(stat:StatData, forceTeff:Boolean):void
        {
            if (stat.v == null)
            {
                stat.v = new VData();
                return;
            }

            stat.v.data = VehicleInfo.get(stat.v.id);
            if (stat.v.data == null)
                return;

            var vdata:VehicleData = stat.v.data;

            // tank rating
            if (isNaN(stat.v.b) || isNaN(stat.v.w) || stat.v.b <= 0)
                stat.v.r = stat.r;
            else
            {
                var Tr:Number = stat.v.w / stat.v.b * 100;
                if (stat.v.b > 100)
                    stat.v.r = Tr;
                else
                {
                    var Or:Number = stat.r;
                    var Tb:Number = stat.v.b / 100.0;
                    var Tl:Number = Math.min(vdata.level, 4) / 4.0;
                    stat.v.r = Or - (Or - Tr) * Tb * Tl;
                }
            }

            if (isNaN(stat.v.b) || stat.v.b <= 0)
                return;

            // skip v.b less then 10, because of WG bug:
            // http://www.koreanrandom.com/forum/topic/1643-/page-19#entry26189
            // forceTeff used in UserInfo, there is not this bug there.
            if (!forceTeff && stat.v.b < 10 + vdata.level * 2)
                return;

            if (!isNaN(stat.v.dmg) && stat.v.dmg > 0)
                stat.v.db = stat.v.dmg / stat.v.b;
            if (!isNaN(stat.v.frg) && stat.v.frg > 0)
                stat.v.fb = stat.v.frg / stat.v.b;
            if (!isNaN(stat.v.spo) && stat.v.spo > 0)
                stat.v.sb = stat.v.spo / stat.v.b;
            //Logger.addObject(stat);

            if (!isNaN(stat.v.dmg) && stat.v.dmg > 0)
                stat.v.dv = stat.v.dmg / stat.v.b / vdata.hpTop;

            if (isNaN(stat.v.db) || isNaN(stat.v.fb) || isNaN(stat.v.sb))
                return;

            var EC:Object = { CD: 3, CF: 1 };
            if (EC.CD != null && EC.CD > 0 && (stat.v.db <= 0))
                return;
            if (EC.CF != null && EC.CF > 0 && (stat.v.fb <= 0))
                return;

            if (vdata.top.D == vdata.avg.D || vdata.top.F == vdata.avg.F)
                return;

            var dD:Number = stat.v.db - vdata.avg.D;
            var dF:Number = stat.v.fb - vdata.avg.F;
            var minD:Number = vdata.avg.D * 0.4;
            var minF:Number = vdata.avg.F * 0.4;
            var d:Number = 1 + dD / (vdata.top.D - vdata.avg.D);
            var f:Number = 1 + dF / (vdata.top.F - vdata.avg.F);
            var d2:Number = (stat.v.db < vdata.avg.D) ? stat.v.db / vdata.avg.D : d;
            var f2:Number = (stat.v.fb < vdata.avg.F) ? stat.v.fb / vdata.avg.F : f;
            d = (stat.v.db < vdata.avg.D) ? 1 + dD / (vdata.avg.D - minD) : d;
            f = (stat.v.fb < vdata.avg.F) ? 1 + dF / (vdata.avg.F - minF) : f;

            d = Math.max(0, d);
            f = Math.max(0, f);
            d2 = Math.max(0, d2);
            f2 = Math.max(0, f2);

            stat.v.te = (d * EC.CD + f * EC.CF) / (EC.CD + EC.CF);
            //stat.teff2 = (d2 * EC.CD + f2 * EC.CF) / (EC.CD + EC.CF);
            //Logger.add(stat.vn + " D:" + d + " F:" + f);

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

            //Logger.add(stat.v.data.shortName + " teff=" + stat.teff + " e:" + stat.te);
            //Logger.addObject(stat);
        }

        private function guessBattleTier():Number
        {
            // 1. Collect all vehicles info
            var vis:Array = [];
            for (var pname:String in Stat.stat)
            {
                var stat:StatData = Stat.getData(pname);
                var vdata:VehicleData = stat.v.data;
                if (vdata == null || vdata.key == "ussr:Observer")
                    continue;
                vis.push( {
                    level: vdata.level,
                    Tmin: vdata.tierLo,
                    Tmax: vdata.tierHi
                });
            }

            if (vis.length == 0)
                return 0;

            // 2. Sort vehicles info by top tiers descending
            vis.sortOn("Tmax", Array.NUMERIC | Array.DESCENDING);

            // 3. Find minimum Tmax and maximum Tmin
            var Tmin:Number = vis[0].Tmin;
            var Tmax:Number = vis[0].Tmax;
            //Logger.add("T before=" + Tmin + ".." + Tmax);
            var vis_length:int = vis.length;
            for (var i:int = 1; i < vis_length; ++i)
            {
                var vi:Object = vis[i];
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
}
