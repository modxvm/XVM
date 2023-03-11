/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.shared.elements
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.infrastructure.interfaces.entity.*;

    public class BattleElements implements IDisposable
    {
        private static const CMD_LOG:String = "$log";
        private static const CMD_DELAY:String = "$delay";
        private static const CMD_INTERVAL:String = "$interval";
        private static const CMD_TEXT_FORMAT:String = "$textFormat";

        private var cfg:Array;
        private var timers:Array = [];

        private var _disposed: Boolean = false;

        public function BattleElements()
        {
            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
            setup();
        }

        public function dispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
            stop();
            _disposed = true;
        }

        public final function isDisposed(): Boolean
        {
            return _disposed;
        }

        // PRIVATE

        private function stop():void
        {
            for each (var timer:Timer in timers)
            {
                if (timer)
                {
                    timer.stop();
                    timer = null;
                }
            }
            timers = [];
        }

        private function setup():void
        {
            stop();
            //Xvm.swfProfilerBegin("BattleElements.setup()");
            try
            {
                var cfg:Array = Config.config.battle.elements;
                var len:int = cfg.length;
                for (var i:int = 0; i < len; ++i)
                {
                    apply(BattleXvmView.battlePage, XfwUtils.jsonclone(cfg[i]), BattleXvmView.battlePage.name);
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            //Xvm.swfProfilerEnd("BattleElements.setup()");
        }

        private function apply(obj:*, opt:*, name:String):void
        {
            //Logger.add(name);
            //Logger.addObject(opt, 1, name);
            if (opt[CMD_LOG])
            {
                var depth:int = opt[CMD_LOG];
                if (depth > 0)
                {
                    Logger.addObject(obj, opt[CMD_LOG], name);
                }
                delete opt[CMD_LOG];
            }

            if (XfwUtils.isPrimitiveType(obj))
            {
                Logger.add("[ELEMENTS] WARNING: " + name + " is a primitive type: " + getQualifiedClassName(obj));
                return;
            }

            var timer:Timer;
            if (opt[CMD_DELAY] > 0)
            {
                timer = new Timer(opt[CMD_DELAY], 1);
                timers.push(timer);
                timer.addEventListener(TimerEvent.TIMER, function(e:Event):void { apply(obj, opt, name); });
                delete opt[CMD_DELAY];
                timer.start();
                return;
            }

            if (opt[CMD_INTERVAL] > 0)
            {
                timer = new Timer(opt[CMD_INTERVAL], 0);
                timers.push(timer);
                timer.addEventListener(TimerEvent.TIMER, function(e:Event):void { apply(obj, opt, name); });
                delete opt[CMD_INTERVAL];
                timer.start();
                return;
            }

            for (var key:String in opt)
            {
                //Logger.add(name + "." + key);
                var obj_value:*;
                try
                {
                    obj_value = obj[key];
                    //Logger.add("  obj_value=" + obj_value);
                } catch (ex:Error)
                {
                    Logger.add("[ELEMENTS] WARNING: " + ex.message + " (" + name + ")")
                    continue;
                }

                var opt_value:* = opt[key];
                //Logger.add("  opt_value=" + opt_value);
                if (key == CMD_TEXT_FORMAT)
                {
                    if (obj is TextField)
                    {
                        applyTextFormat(obj, opt_value, name);
                    }
                    else
                    {
                        Logger.add("[ELEMENTS] WARNING: " + name + " is not a TextField, cannot apply $textFormat");
                    }
                }
                else if (typeof opt_value == "object" && !(opt_value is Array) && obj_value)
                {
                    apply(obj_value, opt_value, name + "." + key);
                }
                else
                {
                    if (!XfwUtils.isPrimitiveType(obj_value))
                    {
                        Logger.add("[ELEMENTS] WARNING: " + name + "." + key + " isn't a primitive type: " + getQualifiedClassName(obj_value));
                    }
                    else if (typeof obj_value == "number")
                    {
                        var numberValue:Number = Macros.FormatNumberGlobal(opt_value);
                        if (!isNaN(numberValue))
                        {
                            //Logger.add(name + "." + key + "=" + numberValue + " (Number)");
                            obj[key] = numberValue;
                        }
                    }
                    else if (obj_value is Boolean)
                    {
                        var booleanValue:Boolean = Macros.FormatBooleanGlobal(opt_value, obj[key]);
                        if (obj_value != booleanValue)
                        {
                            //Logger.add(name + "." + key + "=" + booleanValue + " (Boolean)");
                            obj[key] = booleanValue;
                        }
                    }
                    else if (obj_value is String)
                    {
                        var stringValue:String = Macros.FormatStringGlobal(opt_value);
                        if (obj_value != stringValue)
                        {
                            //Logger.add(name + "." + key + "=" + stringValue + " (String)");
                            obj[key] = stringValue;
                        }
                    }
                    else
                    {
                        Logger.add("[ELEMENTS] WARNING: unknown type for value " + name + "." + key + ": " + getQualifiedClassName(obj_value));
                    }
                }
            }
            //Logger.add("<< " + name);*/
        }

        private function applyTextFormat(textField:TextField, opt:*, name:String):void
        {
            var textFormat:TextFormat = textField.defaultTextFormat;
            apply(textFormat, opt, name + CMD_TEXT_FORMAT);
            textField.defaultTextFormat = textFormat;
        }
    }
}
