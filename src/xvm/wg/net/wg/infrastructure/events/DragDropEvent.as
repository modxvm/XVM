package net.wg.infrastructure.events 
{
    import flash.display.*;
    import flash.events.*;
    
    public class DragDropEvent extends flash.events.Event
    {
        public function DragDropEvent(arg1:String, arg2:flash.display.InteractiveObject, arg3:flash.display.InteractiveObject, arg4:flash.display.InteractiveObject)
        {
            super(arg1, bubbles, cancelable);
            this._sender = arg2;
            this._receiver = arg3;
            this._draggedItem = arg4;
            return;
        }

        public function get draggedItem():flash.display.InteractiveObject
        {
            return this._draggedItem;
        }

        public function get sender():flash.display.InteractiveObject
        {
            return this._sender;
        }

        public function get receiver():flash.display.InteractiveObject
        {
            return this._receiver;
        }

        public static const BEFORE_DROP:String="onBeforeDrop";

        public static const AFTER_DROP:String="onAfterDrop";

        public static const START_DROP:String="onStartDrop";

        public static const END_DROP:String="onEndDrop";

        internal var _sender:flash.display.InteractiveObject=null;

        internal var _receiver:flash.display.InteractiveObject=null;

        internal var _draggedItem:flash.display.InteractiveObject=null;
    }
}
