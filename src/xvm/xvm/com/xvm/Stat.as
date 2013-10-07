/**
 * XVM Config
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm
{
    import com.xvm.events.ObjectEvent;
    import flash.accessibility.AccessibilityProperties;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.external.ExternalInterface;
    import flash.utils.Dictionary;
    import com.xvm.io.*;
    import com.xvm.utils.*;
    import com.xvm.types.stat.*;
    import com.xvm.vehinfo.VehicleInfo;

    public class Stat extends EventDispatcher
    {
        public static const COMPLETE_BATTLE:String = "complete_battle";
        public static const COMPLETE_USERDATA:String = "complete_userdata";

        // instance
        private static var _instance:Stat = null;
        public static function get instance():Stat
        {
            if (_instance == null)
                _instance = new Stat();
            return _instance;
        }

        public static function get infoVersion():String
        {
            return instance.info.ver;
        }

        public static function get infoMessage():String
        {
            return instance.info.message;
        }

        public static function get loaded():Boolean
        {
            return instance.loaded;
        }

        public static function get stat():Dictionary
        {
            return instance.stat;
        }

        public static function getData(name:String):StatData
        {
            return stat.hasOwnProperty(name) ? stat[name] : null;
        }

        public static function isUserDataCachedByName(name:String):Boolean
        {
            var key:String = name + ";0";
            return instance.user.hasOwnProperty(key);
        }

        public static function getUserDataByName(name:String):StatData
        {
            var key:String = name + ";0";
            return instance.user.hasOwnProperty(key) ? instance.user[key] : null;
        }

        public static function getUserDataById(id:String):StatData
        {
            var key:String = id.toString() + ";1";
            return instance.user.hasOwnProperty(key) ? instance.user[key] : null;
        }

        public static function loadBattleStat(target:Object, callback:Function, force:Boolean = false):void
        {
            instance.loadBattleStat(target, callback, force);
        }

        public static function loadUserData(target:Object, callback:Function, value:String, isId:Boolean):void
        {
            instance.loadUserData(target, callback, value, isId);
        }

        // PRIVATE

        private var stat:Dictionary;
        private var user:Dictionary;
        private var info:Object;
        private var loading:Boolean;
        private var loaded:Boolean;
        private var listenersBattle:Vector.<Object>;
        private var listenersUser:Dictionary;

        function Stat()
        {
            info = { ver: null, message: null };
            stat = new Dictionary();
            user = new Dictionary();
            loading = false;
            loaded = false;
            listenersBattle = new Vector.<Object>();
            listenersUser = new Dictionary();
            ExternalInterface.addCallback(Cmd.RESPOND_STATDATA, battleLoaded);
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
            //Logger.add("TRACE: battleLoaded()");

            try
            {
                var response:Object = JSONx.parse(json_str);
                //Logger.addObject(response, "response", 3);

                if (response.info)
                    info = response.info;

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
                        Macros.RegisterMacrosData(name);
                        //Logger.addObject(stat[name], "stat[" + name + "]", 3);
                    }
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
                        Logger.addObject(e, "exception");
                    }
                }
                listenersBattle = new Vector.<Object>();

                dispatchEvent(new Event(COMPLETE_BATTLE));
            }

            //Logger.add("TRACE: battleLoaded(): end");
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
                    var key:String = value + (isId ? ";1" : ";0");
                    if (user.hasOwnProperty(key))
                    {
                        callback.call(target, user[key]);
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
                name = sd.name || sd.nm; // TODO: Company Window in CT?
                //Logger.addObject(response, "response", 2);
                key1 = sd.nm + ";0";
                user[key1] = sd;
                key2 = sd._id + ";1";
                user[key2] = sd;
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
                stat.r = Math.round(stat.w / stat.b * 100);

            // XVM Scale: http://www.koreanrandom.com/forum/topic/2625-xvm-scale

            // xeff
            if (!isNaN(stat.e))
                stat.xeff = XvmScale.XEFF(stat.e);

            // xwn
            if (!isNaN(stat.wn))
                stat.xwn = XvmScale.XWN(stat.wn);

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

            // tank rating
            if (isNaN(stat.v.b) || isNaN(stat.v.w) || isNaN(stat.v.l) || stat.v.b <= 0 || stat.v.l <= 0)
                stat.v.r = stat.r;
            else
            {
                var Tr:Number = Math.round(stat.v.w / stat.v.b * 100);
                if (stat.v.b > 100)
                    stat.v.r = Tr;
                else
                {
                    var Or:Number = stat.r;
                    var Tb:Number = stat.v.b / 100.0;
                    var Tl:Number = Math.min(stat.v.l, 4) / 4.0;
                    stat.v.r = Math.round(Or - (Or - Tr) * Tb * Tl);
                }
            }

            if (isNaN(stat.v.b) || isNaN(stat.v.l))
                return;

            if (stat.v.b <= 0)
                return;

            // skip v.b less then 10, because of WG bug:
            // http://www.koreanrandom.com/forum/topic/1643-/page-19#entry26189
            // forceTeff used in UserInfo, there is not this bug there.
            if (!forceTeff && stat.v.b < 10 + stat.v.l * 2)
                return;

            if (!isNaN(stat.v.d) && stat.v.d > 0)
                stat.v.db = Math.round(stat.v.d / stat.v.b);
            if (!isNaN(stat.v.f) && stat.v.f > 0)
                stat.v.fb = Math.round(stat.v.f / stat.v.b * 10) / 10.0;
            if (!isNaN(stat.v.s) && stat.v.s > 0)
                stat.v.sb = Math.round(stat.v.s / stat.v.b * 10) / 10.0;
            //Logger.addObject(stat);

            if (stat.vn == null)
                return;
            var vi2:Object = VehicleInfo.getInfo2ByVn(stat.vn);
            if (vi2 == null || !vi2.type || !vi2.level)
                return;

            if (!isNaN(stat.v.d) && stat.v.d > 0)
                stat.v.dv = Math.round(stat.v.d / stat.v.b / vi2.hptop * 10) / 10.0;

            if (isNaN(stat.v.db) || isNaN(stat.v.fb) || isNaN(stat.v.sb))
                return;

            var EC:Object = { CD: 3, CF: 1 };
            if (EC.CD != null && EC.CD > 0 && (stat.v.db <= 0))
                return;
            if (EC.CF != null && EC.CF > 0 && (stat.v.fb <= 0))
                return;

            if (vi2.top.D == vi2.avg.D || vi2.top.F == vi2.avg.F)
                return;

            var dD:Number = stat.v.db - vi2.avg.D;
            var dF:Number = stat.v.fb - vi2.avg.F;
            var minD:Number = vi2.avg.D * 0.4;
            var minF:Number = vi2.avg.F * 0.4;
            var d:Number = 1 + dD / (vi2.top.D - vi2.avg.D);
            var f:Number = 1 + dF / (vi2.top.F - vi2.avg.F);
            var d2:Number = (stat.v.db < vi2.avg.D) ? stat.v.db / vi2.avg.D : d;
            var f2:Number = (stat.v.fb < vi2.avg.F) ? stat.v.fb / vi2.avg.F : f;
            d = (stat.v.db < vi2.avg.D) ? 1 + dD / (vi2.avg.D - minD) : d;
            f = (stat.v.fb < vi2.avg.F) ? 1 + dF / (vi2.avg.F - minF) : f;

            d = Math.max(0, d);
            f = Math.max(0, f);
            d2 = Math.max(0, d2);
            f2 = Math.max(0, f2);

            stat.v.te = (d * EC.CD + f * EC.CF) / (EC.CD + EC.CF);
            //stat.teff2 = (d2 * EC.CD + f2 * EC.CF) / (EC.CD + EC.CF);
    //        Logger.add(stat.vn + " D:" + d + " F:" + f + " S:" + s);

            stat.v.teff = Math.max(1, Math.round(stat.v.te * 1000));
            //stat.teff2 = Math.max(1, Math.round(stat.teff2 * 1000));
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

            //Logger.add(stat.vn + " teff=" + stat.teff + " e:" + stat.te);
            //Logger.addObject(stat);
        }
    }

}
