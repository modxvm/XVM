package scaleform.clik.data 
{
    import flash.events.*;
    import scaleform.clik.interfaces.*;
    
    public dynamic class DataProvider extends Array implements scaleform.clik.interfaces.IDataProvider, flash.events.IEventDispatcher
    {
        public function DataProvider(arg1:Array=null)
        {
            super();
            this.dispatcher = new flash.events.EventDispatcher(this);
            this.parseSource(arg1);
            return;
        }

        public function indexOf(arg1:Object, arg2:Function=null):int
        {
            var loc1:*=super.indexOf(arg1);
            if (arg2 != null) 
                arg2(loc1);
            return loc1;
        }

        public function requestItemAt(arg1:uint, arg2:Function=null):Object
        {
            var loc1:*=this[arg1];
            if (arg2 != null) 
                arg2(loc1);
            return loc1;
        }

        public function requestItemRange(arg1:int, arg2:int, arg3:Function=null):Array
        {
            var loc1:*=this.slice(arg1, arg2 + 1);
            if (arg3 != null) 
                arg3(loc1);
            return loc1;
        }

        public function cleanUp():void
        {
            this.splice(0, length);
            return;
        }

        public function invalidate(arg1:uint=0):void
        {
            this.dispatcher.dispatchEvent(new flash.events.Event(flash.events.Event.CHANGE));
            return;
        }

        public function setSource(arg1:Array):void
        {
            this.parseSource(arg1);
            return;
        }

        public function toString():String
        {
            return "[CLIK DataProvider " + this.join(",") + "]";
        }

        protected function parseSource(arg1:Array):void
        {
            if (arg1 == null) 
                return;
            var loc1:*=arg1.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                this[loc2] = arg1[loc2];
                ++loc2;
            }
            return;
        }

        public function addEventListener(arg1:String, arg2:Function, arg3:Boolean=false, arg4:int=0, arg5:Boolean=false):void
        {
            this.dispatcher.addEventListener(arg1, arg2, arg3, arg4, arg5);
            return;
        }

        public function removeEventListener(arg1:String, arg2:Function, arg3:Boolean=false):void
        {
            this.dispatcher.removeEventListener(arg1, arg2, arg3);
            return;
        }

        public function dispatchEvent(arg1:flash.events.Event):Boolean
        {
            return this.dispatcher.dispatchEvent(arg1);
        }

        public function hasEventListener(arg1:String):Boolean
        {
            return this.dispatcher.hasEventListener(arg1);
        }

        public function willTrigger(arg1:String):Boolean
        {
            return this.dispatcher.willTrigger(arg1);
        }

        protected var dispatcher:flash.events.EventDispatcher;
    }
}
