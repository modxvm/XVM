package net.wg.gui.lobby.hangar.maintenance.events
{
    import flash.events.Event;
    
    public class OnEquipmentRendererOver extends Event
    {
        
        public function OnEquipmentRendererOver(param1:String, param2:String = "", param3:Array = null, param4:int = 0, param5:int = 0, param6:uint = 0, param7:Boolean = true, param8:Boolean = false) {
            super(param1,param7,param8);
            this.moduleID = param2;
            this.modulePrices = param3;
            this.inventoryCount = param4;
            this.vehicleCount = param5;
            this.moduleIndex = param6;
        }
        
        public static var ON_EQUIPMENT_RENDERER_OVER:String = "on_equipment_renderer_over";
        
        public var moduleID:String = "";
        
        public var modulePrices:Array = null;
        
        public var inventoryCount:int = 0;
        
        public var vehicleCount:int = 0;
        
        public var moduleIndex:uint = 0;
        
        override public function clone() : Event {
            return new OnEquipmentRendererOver(type,this.moduleID,this.modulePrices,this.inventoryCount,this.vehicleCount,this.moduleIndex,bubbles,cancelable);
        }
        
        override public function toString() : String {
            return formatToString("OnEquipmentRendererOver","type","moduleID","modulePrices","inventoryCount","vehicleCount","moduleIndex","bubbles","cancelable","eventPhase");
        }
    }
}
