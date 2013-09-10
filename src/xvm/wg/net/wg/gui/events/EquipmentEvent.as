package net.wg.gui.events 
{
    import flash.events.*;
    
    public class EquipmentEvent extends flash.events.Event
    {
        public function EquipmentEvent(arg1:String, arg2:int=-1, arg3:int=-1, arg4:String="")
        {
            super(arg1, true, true);
            this.changeIndex = arg2;
            this.changePos = arg3;
            this.changeCurrency = arg4;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.events.EquipmentEvent(type, this.changeIndex, this.changePos, this.changeCurrency);
        }

        public static const NEED_UPDATE:String="needUpdate";

        public static const EQUIPMENT_CHANGE:String="equipmentChange";

        public static const TOTAL_PRICE_CHANGED:String="totalPriceChanged";

        public static const SHOW_INFO:String="showInfo";

        public var changeIndex:int=-1;

        public var changePos:int=-1;

        public var changeCurrency:String="";
    }
}
