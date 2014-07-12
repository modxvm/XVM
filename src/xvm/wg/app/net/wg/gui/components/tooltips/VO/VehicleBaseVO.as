package net.wg.gui.components.tooltips.VO
{
    public class VehicleBaseVO extends Object
    {
        
        public function VehicleBaseVO() {
            super();
        }
        
        public static var DEF_BUY_PRICE:String = "def_buy_price";
        
        public static var DEF_SELL_PRICE:String = "def_sell_price";
        
        public static var ACTION_PRC:String = "action_prc";
        
        public var vName:String = null;
        
        public var vLevel:int = -1;
        
        public var vType:String = null;
        
        public function dispose() : void {
        }
    }
}
