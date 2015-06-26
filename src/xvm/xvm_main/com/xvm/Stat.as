/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm
{
    import com.xfw.*;
    import com.xfw.events.*;
    //import com.xvm.io.*;
    import com.xvm.utils.*;
    import com.xvm.types.stat.*;
    import com.xvm.types.veh.*;
    import flash.events.*;
    //import flash.external.*;
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
            Xfw.addCommandListener(XvmCommandsInternal.AS_STAT_BATTLE_DATA, battleLoaded);
            Xfw.addCommandListener(XvmCommandsInternal.AS_STAT_BATTLE_RESULTS_DATA, battleResultsLoaded);
            Xfw.addCommandListener(XvmCommandsInternal.AS_STAT_USER_DATA, userLoaded);
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

                Xfw.cmd(XvmCommandsInternal.LOAD_STAT_BATTLE);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
                throw ex;
            }
        }

        private function battleLoaded(json_str:String):Object
        {
            //Logger.add("TRACE: battleLoaded()");

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
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
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
                    catch (ex:Error)
                    {
                        Logger.err(ex);
                    }
                    catch (ex:*)
                    {
                        Logger.addObject(ex, 1, "exception");
                    }
                }
                listenersBattle = new Vector.<Object>();

                dispatchEvent(new Event(COMPLETE_BATTLE));
            }

            //Logger.add("TRACE: battleLoaded(): end");

            return null;
        }

        private function loadBattleResultsStat(target:Object, callback:Function, arenaUniqueId:String):void
        {
            //Logger.add("TRACE: loadBattleResultsStat(): target=" + String(target));
            if (arenaUniqueId == null || arenaUniqueId == "" || arenaUniqueId == "0")
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
                Xfw.cmd(XvmCommandsInternal.LOAD_STAT_BATTLE_RESULTS, arenaUniqueId);
        }

        private function battleResultsLoaded(json_str:String):Object
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
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
                Logger.add(json_str);
                throw ex;
            }
            catch (ex:*)
            {
                Logger.add(ex);
            }
            finally
            {
                if (arenaUniqueId == null)
                    return null;
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
                catch (ex:Error)
                {
                    Logger.err(ex);
                }
                dispatchEvent(new ObjectEvent(COMPLETE_BATTLERESULTS, arenaUniqueId));
            }

            return null;
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
                    var key:String = (isId ? "ID" : Config.config.region) + "/" + value;
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
                    Xfw.cmd(XvmCommandsInternal.LOAD_STAT_USER, value, isId);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
                throw ex;
            }
        }

        private function userLoaded(json_str:String):Object
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
                key1 = Config.config.region + "/" + name;
                userCache[key1] = sd;
                key2 = "ID/" + sd._id;
                userCache[key2] = sd;
                //Logger.add(key1 + ", " + key2);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
                throw ex;
            }
            finally
            {
                processUserListener(key1);
                processUserListener(key2);
                dispatchEvent(new ObjectEvent(COMPLETE_USERDATA, name));
            }

            return null;
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
            catch (ex:Error)
            {
                Logger.err(ex);
            }
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
