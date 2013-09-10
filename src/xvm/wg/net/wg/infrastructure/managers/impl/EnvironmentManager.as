package net.wg.infrastructure.managers.impl 
{
    import flash.events.*;
    import flash.external.*;
    import flash.system.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.exceptions.*;
    import net.wg.infrastructure.managers.*;
    
    public final class EnvironmentManager extends flash.events.EventDispatcher implements net.wg.infrastructure.managers.IEnvironmentManager
    {
        public function EnvironmentManager()
        {
            super();
            ms_instance = this;
            return;
        }

        public function quit():void
        {
            this.dofsCommand(net.wg.infrastructure.events.EnvironmentEvent.QIUT);
            return;
        }

        public function logoff():void
        {
            this.dofsCommand(net.wg.infrastructure.events.EnvironmentEvent.LOGOFF);
            return;
        }

        public final function useEventSystem():void
        {
            this._useEventSystem = true;
            return;
        }

        public final function useExternallInterface():void
        {
            this._useEventSystem = false;
            return;
        }

        public final function addCallback(arg1:String, arg2:Function):void
        {
            if (this._useEventSystem) 
                addEventListener(arg1, arg2);
            else 
                flash.external.ExternalInterface.addCallback(arg1, arg2);
            return;
        }

        public final function call(... rest):*
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            this._result = null;
            if (this._useEventSystem) 
            {
                if (rest.length == 0 || rest == null) 
                {
                    loc2 = "cmd can`t be null, when arguments count is zero";
                    throw new net.wg.infrastructure.exceptions.EnvironmentException(loc2);
                }
                loc1 = rest.shift() as String;
                if (loc1 == null || loc1 == "") 
                {
                    loc3 = "First argument must be a string and non-zero value";
                    throw new net.wg.infrastructure.exceptions.EnvironmentException(loc3);
                }
                dispatchEvent(new net.wg.infrastructure.events.EnvironmentEvent(loc1, rest));
            }
            else 
                return flash.external.ExternalInterface.call.apply(this, rest);
            return this._result;
        }

        public final function envoke(arg1:String):*
        {
            this._result = null;
            if (this._useEventSystem) 
                dispatchEvent(new net.wg.infrastructure.events.EnvironmentEvent(arg1, []));
            else 
                return flash.external.ExternalInterface.call(arg1);
            return;
        }

        public function setLastResult(arg1:Object):void
        {
            this._result = arg1;
            return;
        }

        internal function dofsCommand(arg1:String):void
        {
            if (this._useEventSystem) 
                dispatchEvent(new net.wg.infrastructure.events.EnvironmentEvent(arg1));
            else 
                flash.system.fscommand(arg1);
            return;
        }

        public static function getInstance():net.wg.infrastructure.managers.IEnvironmentManager
        {
            if (ms_instance == null) 
                ms_instance = new EnvironmentManager();
            return ms_instance;
        }

        
        {
            ms_instance = null;
        }

        internal var _useEventSystem:Boolean=false;

        internal var _result:Object=null;

        internal static var ms_instance:net.wg.infrastructure.managers.impl.EnvironmentManager=null;
    }
}
