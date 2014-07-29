package net.wg.gui.events
{
    import flash.events.Event;
    import net.wg.infrastructure.interfaces.IViewStackContent;
    
    public class ViewStackEvent extends Event
    {
        
        public function ViewStackEvent(param1:String, param2:IViewStackContent, param3:String, param4:Boolean = false, param5:Boolean = false)
        {
            super(param1,param4,param5);
            this.view = param2;
            this.linkage = param3;
        }
        
        public static var NEED_UPDATE:String = "need_update";
        
        public static var VIEW_CHANGED:String = "view_changed";
        
        public var view:IViewStackContent;
        
        public var linkage:String;
        
        override public function clone() : Event
        {
            return new ViewStackEvent(type,this.view,this.linkage,bubbles,cancelable);
        }
        
        override public function toString() : String
        {
            return formatToString("ViewStackEvent","view","linkage","type","bubbles","cancelable","eventPhase");
        }
    }
}
