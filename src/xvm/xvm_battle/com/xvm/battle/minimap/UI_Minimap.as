package com.xvm.battle.minimap 
{
	import com.xfw.*;
    import com.xvm.*;
    import com.xfw.events.*;
    import com.xvm.battle.*;
	import com.xvm.battle.minimap.entries.vehicle.UI_StrategicCameraEntry;
	import com.xvm.battle.minimap.entries.vehicle.UI_VehicleEntry;
    import com.xvm.types.cfg.*
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getQualifiedClassName;
	
	UI_VehicleEntry;
	UI_StrategicCameraEntry;
	dynamic public class UI_Minimap extends minimapUI
	{
		private var _cfg:CMinimap;
		
		public function UI_Minimap(cfg:CMinimap) 
		{
			_cfg = cfg;

			 Logger.add("UI_Minimap | UI_Minimap");
			 //Logger.add("UI_Minimap | UI_Minimap | className: "+getQualifiedClassName(UI_VehicleEntry));

		}
		
		override protected function configUI():void
        {
			Logger.add("UI_Minimap | configUI");

            

            //onConfigLoaded(null);
        }
	}

}