/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.battle.events.*;
    import com.xvm.types.stat.*;
    import flash.events.*;

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

        public static function get battleStat():Object
        {
            return instance.battleCache;
        }

        public static function getBattleResultsStat(arenaUniqueID:String):Object
        {
            return instance.battleResultsCache[arenaUniqueID];
        }

        public static function isUserDataCachedByName(name:String):Boolean
        {
            var key:String = Config.config.region + "/" + name;
            return (key in instance.userCache);
        }

        public static function getUserDataByName(name:String):StatData
        {
            var key:String = Config.config.region + "/" + name;
            return (key in instance.userCache) ? instance.userCache[key] : null;
        }

        public static function getUserDataById(id:uint):StatData
        {
            var key:String = "ID/" + id.toString();
            return (key in instance.userCache) ? instance.userCache[key] : null;
        }

        public static function clearBattleStat():void
        {
            instance.battleCache = {};
        }

        public static function loadBattleStat():void
        {
            instance.loadBattleStat();
        }

        public static function loadBattleResultsStat(arenaUniqueID:String):void
        {
            instance.loadBattleResultsStat(arenaUniqueID);
        }

        public static function loadUserData(value:String):void
        {
            instance.loadUserData(value);
        }

        // PRIVATE

        private var battleStatLoading:Boolean;
        private var battleStatLoaded:Boolean;
        private var battleCache:Object;
        private var battleResultsCache:Object;
        private var userCache:Object;
        private var activeUserRequests:Object;

        function Stat()
        {
            battleStatLoading = false;
            battleStatLoaded = false;
            battleCache = {};
            battleResultsCache = {};
            userCache = {};
            activeUserRequests = {};
            Xfw.addCommandListener(XvmCommandsInternal.AS_STAT_BATTLE_DATA, battleLoaded);
            Xfw.addCommandListener(XvmCommandsInternal.AS_STAT_BATTLE_RESULTS_DATA, battleResultsLoaded);
            Xfw.addCommandListener(XvmCommandsInternal.AS_STAT_USER_DATA, userLoaded);
        }

        private function loadBattleStat():void
        {
            //Logger.add("TRACE: loadBattleStat()");
            if (battleStatLoading)
                return;
            battleStatLoading = true;
            Xfw.cmd(XvmCommandsInternal.LOAD_STAT_BATTLE);
        }

        private function battleLoaded(data:Object):Object
        {
            //Logger.add("TRACE: battleLoaded()");
            var updatedPlayers:Array = [];
            try
            {
                //Logger.addObject(data, 3);
                updatedPlayers = parseResult(data, battleCache);
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
                dispatchEvent(new ObjectEvent(COMPLETE_BATTLE, updatedPlayers));
            }
            //Logger.add("TRACE: battleLoaded(): end");
            return null;
        }

        private function loadBattleResultsStat(arenaUniqueID:String):void
        {
            //Logger.add("TRACE: loadBattleResultsStat()");
            if (!arenaUniqueID || arenaUniqueID == "0")
            {
                dispatchEvent(new ObjectEvent(COMPLETE_BATTLERESULTS, arenaUniqueID));
            }
            else
            {
                Xfw.cmd(XvmCommandsInternal.LOAD_STAT_BATTLE_RESULTS, arenaUniqueID);
            }
        }

        private function battleResultsLoaded(data:Object):Object
        {
            //Logger.add("TRACE: battleResultsLoaded()");
            var arenaUniqueID:String = null;
            try
            {
                //Logger.addObject(data, 3);
                arenaUniqueID = data.arenaUniqueID;
                battleResultsCache[arenaUniqueID] = {};
                parseResult(data, battleResultsCache[arenaUniqueID]);
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
                dispatchEvent(new ObjectEvent(COMPLETE_BATTLERESULTS, arenaUniqueID));
            }
            return null;
        }

        private function parseResult(data:Object, cache:Object):Array
        {
            var updatedPlayers:Array = [];
            if (data.players)
            {
                for (var name:String in data.players)
                {
                    var sd:StatData = ObjectConverter.convertData(data.players[name], StatData);
                    updatedPlayers.push(name);
                    if (sd.v == null)
                    {
                        sd.v = new VData();
                    }
                    else
                    {
                        sd.v.data = VehicleInfo.get(sd.v.id);
                    }
                    cache[name] = sd;
                    Macros.RegisterStatisticsMacros(name, sd);
                    //Logger.addObject(sd, 3, "stat[" + name + "]");
                }
            }
            return updatedPlayers;
        }

        private function loadUserData(name:String):void
        {
            //Logger.add("TRACE: loadUserData()");
            try
            {
                if (!name)
                {
                    dispatchEvent(new ObjectEvent(COMPLETE_USERDATA, null));
                    return;
                }
                if (!(name in activeUserRequests))
                {
                    activeUserRequests[name] = true;
                    Xfw.cmd(XvmCommandsInternal.LOAD_STAT_USER, name);
                }
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
                if (sd.vehicles != null)
                {
                    for (var tankId:String in sd.vehicles)
                    {
                        sd.vehicles[tankId] = ObjectConverter.convertData(sd.vehicles[tankId], VData);
                    }
                }
                name = sd.name || sd.name_db;
                keyName = Config.config.region + "/" + name;
                userCache[keyName] = sd;
                keyId = "ID/" + sd.player_id;
                userCache[keyId] = sd;
                delete activeUserRequests[name];
            }
            catch (ex:Error)
            {
                Logger.err(ex);
                throw ex;
            }
            finally
            {
                dispatchEvent(new ObjectEvent(COMPLETE_USERDATA, name));
                if (name == Xfw.cmd(XvmCommands.GET_PLAYER_NAME))
                {
                    Xvm.dispatchEvent(new PlayerStateEvent(PlayerStateEvent.ON_MY_STAT_LOADED));
                }
            }
            return null;
        }
    }
}
