package net.wg.infrastructure.managers.utils.impl 
{
    public class EventListnerProxy extends Object
    {
        public function EventListnerProxy(arg1:Object, arg2:String, arg3:Function, arg4:Boolean)
        {
            super();
            this.objRef = arg1;
            this.eventRef = arg2;
            this.funcRef = arg3;
            this._useCapture = arg4;
            return;
        }

        public function finalize():void
        {
            this.objRef = null;
            this.eventRef = null;
            this.funcRef = null;
            return;
        }

        public function get obj():Object
        {
            return this.objRef;
        }

        public function get event():String
        {
            return this.eventRef;
        }

        public function get func():Function
        {
            return this.funcRef;
        }

        public function get useCapture():Boolean
        {
            return this._useCapture;
        }

        public function set useCapture(arg1:Boolean):void
        {
            this._useCapture = arg1;
            return;
        }

        internal var objRef:Object;

        internal var eventRef:String;

        internal var funcRef:Function;

        internal var _useCapture:Boolean;
    }
}
