package net.wg.infrastructure.events 
{
    import flash.events.*;
    import net.wg.infrastructure.interfaces.*;
    
    public class LoaderEvent extends flash.events.Event
    {
        public function LoaderEvent(arg1:String, arg2:Object, arg3:String=null, arg4:net.wg.infrastructure.interfaces.IView=null)
        {
            super(arg1, true, true);
            this.config = arg2;
            this.token = arg3;
            this.view = arg4;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.infrastructure.events.LoaderEvent(type, this.config, this.token, this.view);
        }

        public static const VIEW_LOADED:String="viewLoaded";

        public static const CURSOR_LOADED:String="cursorLoaded";

        public static const WAITING_LOADED:String="waitingLoaded";

        public static const VIEW_LOAD_ERROR:String="viewLoadError";

        public static const VIEW_INIT_ERROR:String="viewInitError";

        public var view:net.wg.infrastructure.interfaces.IView;

        public var config:Object;

        public var token:String;
    }
}
