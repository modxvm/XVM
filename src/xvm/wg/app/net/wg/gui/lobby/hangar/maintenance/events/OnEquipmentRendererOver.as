package net.wg.gui.lobby.hangar.maintenance.events 
{
    import flash.events.*;
    
    public class OnEquipmentRendererOver extends flash.events.Event
    {
        public function OnEquipmentRendererOver(arg1:String, arg2:String="", arg3:Array=null, arg4:int=0, arg5:int=0, arg6:uint=0, arg7:Boolean=true, arg8:Boolean=false)
        {
            super(arg1, arg7, arg8);
            this.moduleID = arg2;
            this.modulePrices = arg3;
            this.inventoryCount = arg4;
            this.vehicleCount = arg5;
            this.moduleIndex = arg6;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.lobby.hangar.maintenance.events.OnEquipmentRendererOver(type, this.moduleID, this.modulePrices, this.inventoryCount, this.vehicleCount, this.moduleIndex, bubbles, cancelable);
        }

        public override function toString():String
        {
            return formatToString("OnEquipmentRendererOver", "type", "moduleID", "modulePrices", "inventoryCount", "vehicleCount", "moduleIndex", "bubbles", "cancelable", "eventPhase");
        }

        
        {
            ON_EQUIPMENT_RENDERER_OVER = "on_equipment_renderer_over";
        }

        public var moduleID:String="";

        public var modulePrices:Array=null;

        public var inventoryCount:int=0;

        public var vehicleCount:int=0;

        public var moduleIndex:uint=0;

        public static var ON_EQUIPMENT_RENDERER_OVER:String="on_equipment_renderer_over";
    }
}
