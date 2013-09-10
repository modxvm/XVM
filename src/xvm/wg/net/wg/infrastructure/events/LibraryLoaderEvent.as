package net.wg.infrastructure.events 
{
    import flash.display.*;
    import flash.events.*;
    
    public class LibraryLoaderEvent extends flash.events.Event
    {
        public function LibraryLoaderEvent(arg1:String, arg2:flash.display.Loader, arg3:String, arg4:Boolean=false, arg5:Boolean=false)
        {
            super(arg1, arg4, arg5);
            this.loader = arg2;
            this.url = arg3;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.infrastructure.events.LibraryLoaderEvent(type, this.loader, this.url, bubbles, cancelable);
        }

        public override function toString():String
        {
            return formatToString("LibraryLoaderEvent", "type", "bubbles", "cancelable", "eventPhase");
        }

        public static const LOADED:String="libLoaded";

        public var loader:flash.display.Loader;

        public var url:String;
    }
}
