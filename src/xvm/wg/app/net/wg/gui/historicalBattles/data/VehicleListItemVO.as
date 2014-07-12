package net.wg.gui.historicalBattles.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class VehicleListItemVO extends DAAPIDataClass
    {
        
        public function VehicleListItemVO(param1:Object) {
            super(param1);
        }
        
        public var intCD:int;
        
        public var invID:int;
        
        public var name:String = "";
        
        public var image:String = "";
        
        public var enabled:Boolean = true;
        
        public var selectable:Boolean = true;
        
        public var showWarning:Boolean = false;
        
        public var warnTTHeader:String = "";
        
        public var warnTTBody:String = "";
    }
}
