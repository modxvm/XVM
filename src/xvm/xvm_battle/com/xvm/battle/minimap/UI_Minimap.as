package com.xvm.battle.minimap 
{
	import com.xfw.*;
    import com.xvm.*;
    import com.xfw.events.*;
    import com.xvm.battle.*;
	import com.xvm.battle.minimap.entries.vehicle.UI_StrategicCameraEntry;
	import com.xvm.battle.minimap.entries.vehicle.UI_VehicleEntry;
	import com.xvm.battle.vo.VOPlayerState;
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

		}
		
		override protected function configUI():void
        {
			super.configUI();
			Xfw.addCommandListener(BattleCommands.AS_UPDATE_PLAYER_STATE, updatePlayerState);
        }
		
		private function updatePlayerState(vehicleId:Number, data:Object):void 
		{
			var needDispatch:Boolean = false;
			var d:VOPlayerState = BattleState.get(vehicleId);
			if(d && data.hasOwnProperty("curHealth")){
				d._curHealth = data["curHealth"];
				needDispatch = true;
			}
			

			if(d && data.hasOwnProperty("maxHealth") && d._maxHealth != data["maxHealth"]){
				d._maxHealth = data["maxHealth"];
				if(isNaN(d._curHealth)){
					d._curHealth = d._maxHealth;
				}
				needDispatch = true;
				
			}
			
			if(needDispatch){
				Xvm.dispatchEvent(new EntryInfoChangeEvent(EntryInfoChangeEvent.INFO_CHANGED, vehicleId, d));
			}	
			
		}
	}

}