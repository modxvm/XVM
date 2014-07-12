package net.wg.gui.events
{
    import flash.events.Event;
    
    public class ShowDialogEvent extends Event
    {
        
        public function ShowDialogEvent(param1:String, param2:String = "") {
            super(param1,true,true);
            this.id = param2;
        }
        
        public static var SHOW_MESSAGE_DIALOG:String = "showMessageDialog";
        
        public static var SHOW_BERTH_BUY_DIALOG:String = "showBerthBuyDialog";
        
        public static var SHOW_DISSMISS_TANKMAN_DIALOG:String = "showDismissTankmanDialog";
        
        public var id:String;
        
        override public function clone() : Event {
            return new ShowDialogEvent(type,this.id);
        }
    }
}
