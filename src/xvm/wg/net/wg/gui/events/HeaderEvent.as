package net.wg.gui.events 
{
    import flash.events.*;
    
    public class HeaderEvent extends flash.events.Event
    {
        public function HeaderEvent(arg1:String, arg2:String="")
        {
            super(arg1, true, true);
            this.id = arg2;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.events.HeaderEvent(type, this.id);
        }

        public static const SHOW_MESSAGE_DIALOG:String="showMessageDialog";

        public static const SHOW_PREMIUM:String="showPremium";

        public static const SHOW_EXCHANGE:String="showExchange";

        public static const SHOW_XP_EXCHANGE:String="showXPExchange";

        public static const PAYMENT_BTN_CLICK:String="paymentBtnClick";

        public static const SHOW_MENU:String="showMenu";

        public static const LOAD_VIEW:String="loadView";

        public static const LOAD_HANGAR:String="loadHangar";

        public static const LOAD_INVENTORY:String="loadInventory";

        public static const LOAD_SHOP:String="loadShop";

        public static const LOAD_PROFILE:String="LoadProfile";

        public static const LOAD_TECHTREE:String="LoadTechtree";

        public static const LOAD_BARRAKS:String="LoadBarracks";

        public var id:String;
    }
}
