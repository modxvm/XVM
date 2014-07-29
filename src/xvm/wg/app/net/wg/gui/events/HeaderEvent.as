package net.wg.gui.events
{
    import flash.events.Event;
    
    public class HeaderEvent extends Event
    {
        
        public function HeaderEvent(param1:String, param2:String = "")
        {
            super(param1,true,true);
            this.id = param2;
        }
        
        public static var SHOW_MESSAGE_DIALOG:String = "showMessageDialog";
        
        public static var SHOW_PREMIUM:String = "showPremium";
        
        public static var SHOW_EXCHANGE:String = "showExchange";
        
        public static var SHOW_XP_EXCHANGE:String = "showXPExchange";
        
        public static var PAYMENT_BTN_CLICK:String = "paymentBtnClick";
        
        public static var SHOW_MENU:String = "showMenu";
        
        public static var LOAD_VIEW:String = "loadView";
        
        public static var LOAD_HANGAR:String = "loadHangar";
        
        public static var LOAD_INVENTORY:String = "loadInventory";
        
        public static var LOAD_SHOP:String = "loadShop";
        
        public static var LOAD_PROFILE:String = "LoadProfile";
        
        public static var LOAD_TECHTREE:String = "LoadTechtree";
        
        public static var LOAD_BARRAKS:String = "LoadBarracks";
        
        public var id:String;
        
        override public function clone() : Event
        {
            return new HeaderEvent(type,this.id);
        }
    }
}
