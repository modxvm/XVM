package net.wg.data.daapi.base 
{
    import flash.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.interfaces.*;
    
    public class DAAPIDataProvider extends flash.events.EventDispatcher implements scaleform.clik.interfaces.IDataProvider, net.wg.infrastructure.interfaces.IDAAPIModule
    {
        public function DAAPIDataProvider()
        {
            super();
            return;
        }

        public function get disposed():Boolean
        {
            return false;
        }

        public function get length():uint
        {
            if (this.lengthHandler != null) 
            {
                return this.lengthHandler();
            }
            return 0;
        }

        public function requestItemAt(arg1:uint, arg2:Function=null):Object
        {
            var loc1:*=this.requestItemAtHandler(arg1);
            if (arg2 != null) 
            {
                arg2(loc1);
            }
            return loc1;
        }

        public function requestItemRange(arg1:int, arg2:int, arg3:Function=null):Array
        {
            if (!Boolean(this.requestItemRangeHandler)) 
            {
                return [];
            }
            var loc1:*=this.requestItemRangeHandler(arg1, arg2);
            if (arg3 != null) 
            {
                arg3(loc1);
            }
            return loc1;
        }

        public function indexOf(arg1:Object, arg2:Function=null):int
        {
            if (arg2 != null) 
            {
                arg2(-1);
            }
            return -1;
        }

        public function cleanUp():void
        {
            return;
        }

        public function triggerInvalidation():void
        {
            this.invalidate(this.lengthHandler());
            return;
        }

        public function invalidate(arg1:uint=0):void
        {
            dispatchEvent(new flash.events.Event(flash.events.Event.CHANGE));
            return;
        }

        public function as_populate():void
        {
            return;
        }

        public function as_dispose():void
        {
            return;
        }

        public var lengthHandler:Function;

        public var requestItemAtHandler:Function;

        public var requestItemRangeHandler:Function;
    }
}
