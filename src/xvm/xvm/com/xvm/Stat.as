/**
 * XVM Config
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm
{
    import flash.accessibility.AccessibilityProperties;
    import flash.external.ExternalInterface;
    import flash.utils.Dictionary;
    import com.xvm.io.*;
    import com.xvm.utils.*;
    import com.xvm.types.stat.*;
    import com.xvm.vehinfo.VehicleInfo;

    public class Stat
    {
        // instance
        private static var _instance:Stat = null;
        private static function get instance():Stat
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
            return stat[name];
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
            }

            //Logger.add("TRACE: battleLoaded(): end");
        }

        private function loadUserData(target:Object, callback:Function, value:String, isId:Boolean):void
        {
            //Logger.add("TRACE: loadUserStat(): target=" + String(target));
            try
            {
                if (callback != null)
                {
                    var key:String = value + (isId ? ";1" : ";0");
                    listenersUser[key] = { target:target, callback:callback };
                }

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
            //Logger.add("TRACE: statLoaded()");
            try
            {
                var response:Object = JSONx.parse(json_str);
                //Logger.addObject(response, "response", 2);
            }
            catch (e:Error)
            {
                Logger.add(e.getStackTrace());
                throw e;
            }
            finally
            {
                var l:Object = listenersUser[response.name];
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
                delete listenersUser[response.name];
            }
        }

        public function calculateStatValues(stat:StatData, forceTeff:Boolean = false):void
        {
            // rating (GWR)
            stat.r = stat.b > 0 ? Math.round(stat.w / stat.b * 100) : 0;

            // tank rating
            if (stat.v == null)
                stat.v = new VData();
            if (stat.v.b <= 0 || stat.v.l <= 0)
                stat.v.r = stat.r;
            else
            {
                var Tr:int = Math.round(stat.v.w / stat.v.b * 100);
                if (stat.v.b > 100)
                    stat.v.r = Tr;
                else
                {
                    var Or:int = stat.r;
                    var Tb:Number = stat.v.b / 100.0;
                    var Tl:Number = Math.min(stat.v.l, 4) / 4.0;
                    stat.v.r = Math.round(Or - (Or - Tr) * Tb * Tl);
                }
            }

            // XVM Scale: http://www.koreanrandom.com/forum/topic/2625-xvm-scale

            // xeff
            stat.xeff = NaN;
            if (stat.e > 0)
                stat.xeff = XvmScale.XEFF(stat.e);

            // xwn
            stat.xwn = NaN;
            if (stat.wn > 0)
                stat.xwn = XvmScale.XWN(stat.wn);

            // tdb, tfb, tsb, tdv, te, teff (last)
            stat.v.db = NaN;
            stat.v.fb = NaN;
            stat.v.sb = NaN;
            stat.v.dv = NaN;
            stat.v.te = NaN;
            stat.v.teff = NaN;
            // skip v.b less then 10, because of WG bug:
            // http://www.koreanrandom.com/forum/topic/1643-/page-19#entry26189
            // forceTeff used in UserInfo, there is not this bug there.
            if (stat.v != null && stat.v.b > 0 && (forceTeff == true || stat.v.b >= 10 + stat.v.l * 2))
            {
                stat.v.db = (stat.v.d < 0) ? null : Math.round(stat.v.d / stat.v.b);
                stat.v.fb = (stat.v.f < 0) ? null : Math.round(stat.v.f / stat.v.b * 10) / 10;
                stat.v.sb = (stat.v.s < 0) ? null : Math.round(stat.v.s / stat.v.b * 10) / 10;
                //Logger.addObject(stat);

                var vi2:Object = VehicleInfo.getInfo2ByVn(stat.vn);
                if (vi2 != null && vi2.type && vi2.level)
                {
                    stat.v.dv = (stat.v.d < 0) ? null : Math.round(stat.v.d / stat.v.b / vi2.hptop * 10) / 10.0;

                    var EC:Object = { CD: 3, CF: 1 };
            //        Logger.addObject(stat);
            //        Logger.addObject(EC);
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

            //        Logger.add(stat.vn + " teff=" + stat.teff + " e:" + stat.te);
            //        Logger.addObject(stat);
                }
            }

            return;
        }
    }

}
