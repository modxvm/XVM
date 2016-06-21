/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.types.stat.*;
    import com.xvm.types.veh.*;
    import flash.events.*;
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

        public static function get battleStatLoaded():Boolean
        {
            return instance.battleStatLoaded;
        }

        public static function get battleStat():Dictionary
        {
            return instance.battleCache;
        }

        public static function getBattleResultsStat(arenaUniqueId:String):Dictionary
        {
            return instance.battleResultsCache[arenaUniqueId];
        }

        public static function isUserDataCachedByName(name:String):Boolean
        {
            var key:String = Config.config.region + "/" + name;
            return instance.userCache.hasOwnProperty(key);
        }

        public static function getUserDataByName(name:String):StatData
        {
            var key:String = Config.config.region + "/" + name;
            return instance.userCache.hasOwnProperty(key) ? instance.userCache[key] : null;
        }

        public static function getUserDataById(id:uint):StatData
        {
            var key:String = "ID/" + id.toString();
            return instance.userCache.hasOwnProperty(key) ? instance.userCache[key] : null;
        }

        public static function clearBattleStat():void
        {
            instance.battleCache = new Dictionary();
        }

        public static function loadBattleStat():void
        {
            instance.loadBattleStat();
        }

        public static function loadBattleResultsStat(arenaUniqueId:String):void
        {
            instance.loadBattleResultsStat(arenaUniqueId);
        }

        public static function loadUserData(value:String):void
        {
            instance.loadUserData(value);
        }

        // PRIVATE

        private var battleStatLoading:Boolean;
        private var battleStatLoaded:Boolean;
        private var battleCache:Dictionary;
        private var battleResultsCache:Dictionary;
        private var userCache:Dictionary;

        function Stat()
        {
            battleStatLoading = false;
            battleStatLoaded = false;
            battleCache = new Dictionary();
            battleResultsCache = new Dictionary();
            userCache = new Dictionary();
            Xfw.addCommandListener(XvmCommandsInternal.AS_STAT_BATTLE_DATA, battleLoaded);
            Xfw.addCommandListener(XvmCommandsInternal.AS_STAT_BATTLE_RESULTS_DATA, battleResultsLoaded);
            Xfw.addCommandListener(XvmCommandsInternal.AS_STAT_USER_DATA, userLoaded);
        }

        private function loadBattleStat():void
        {
            //Logger.add("TRACE: loadBattleStat()");
            if (!battleStatLoading)
                return;
            battleStatLoading = true;
            Xfw.cmd(XvmCommandsInternal.LOAD_STAT_BATTLE);
        }

        private function battleLoaded(data:Object):Object
        {
            //Logger.add("TRACE: battleLoaded()");
            try
            {
                //Logger.addObject(data, 3);
                parseResult(data, battleCache);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
                Logger.addObject(data);
                throw ex;
            }
            finally
            {
                battleStatLoaded = true;
                battleStatLoading = false;
                //Logger.add("Stat Loaded");
                dispatchEvent(new Event(COMPLETE_BATTLE));
            }
            //Logger.add("TRACE: battleLoaded(): end");
            return null;
        }

        private function loadBattleResultsStat(arenaUniqueId:String):void
        {
            //Logger.add("TRACE: loadBattleResultsStat()");
            if (arenaUniqueId == null || arenaUniqueId == "" || arenaUniqueId == "0")
            {
                dispatchEvent(new ObjectEvent(COMPLETE_BATTLERESULTS, arenaUniqueId));
            }
            else
            {
                Xfw.cmd(XvmCommandsInternal.LOAD_STAT_BATTLE_RESULTS, arenaUniqueId);
            }
        }

        private function battleResultsLoaded(data:Object):Object
        {
            //Logger.add("TRACE: battleResultsLoaded()");
            var arenaUniqueId:String = null;
            try
            {
                //Logger.addObject(data, 3);
                arenaUniqueId = data.arenaUniqueId;
                battleResultsCache[arenaUniqueId] = new Dictionary();
                parseResult(data, battleResultsCache[arenaUniqueId]);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
                Logger.addObject(data);
                throw ex;
            }
            catch (ex:*)
            {
                Logger.add(ex);
            }
            finally
            {
                dispatchEvent(new ObjectEvent(COMPLETE_BATTLERESULTS, arenaUniqueId));
            }
            return null;
        }

        private function parseResult(data:Object, cache:Dictionary):void
        {
            if (data.players)
            {
                for (var name:String in data.players)
                {
                    var sd:StatData = ObjectConverter.convertData(data.players[name], StatData);
                    calculateStatValues(sd);
                    cache[name] = sd;
                    Macros.RegisterStatisticsMacros(name, sd);
                    //Logger.addObject(sd, 3, "stat[" + name + "]");
                }
            }
        }

        private function loadUserData(value:String):void
        {
            //Logger.add("TRACE: loadUserData()");
            try
            {
                if (value == null || value == "")
                {
                    dispatchEvent(new ObjectEvent(COMPLETE_USERDATA, null));
                    return;
                }
                Xfw.cmd(XvmCommandsInternal.LOAD_STAT_USER, value);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
                throw ex;
            }
        }

        private function userLoaded(data:Object):Object
        {
            //Logger.add("TRACE: userLoaded()");
            var name:String = null;
            var keyName:String = null;
            var keyId:String = null;
            try
            {
                var sd:StatData = ObjectConverter.convertData(data, StatData);
                calculateStatValues(sd);
                name = sd.name || sd.nm;
                //Logger.addObject(sd, 2);
                keyName = Config.config.region + "/" + name;
                userCache[keyName] = sd;
                keyId = "ID/" + sd._id;
                userCache[keyId] = sd;
            }
            catch (ex:Error)
            {
                Logger.err(ex);
                throw ex;
            }
            finally
            {
                dispatchEvent(new ObjectEvent(COMPLETE_USERDATA, name));
            }
            return null;
        }

        // TODO: remove
        public function calculateStatValues(stat:StatData):void
        {
            if (stat.v == null)
            {
                stat.v = new VData();
            }
            else
            {
                stat.v.data = VehicleInfo.get(stat.v.id);
            }
        }
    }
}
