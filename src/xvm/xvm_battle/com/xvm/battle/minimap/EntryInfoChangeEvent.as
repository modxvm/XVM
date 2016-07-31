package com.xvm.battle.minimap 
{
	import com.xvm.battle.vo.VOPlayerState;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author s_sorochich
	 */
	public class EntryInfoChangeEvent extends Event 
	{
		public var data:VOPlayerState;
		public var vehicleID:Number;
		public static const INFO_CHANGED:String = "info_changed";
		public function EntryInfoChangeEvent(type:String, vehicleId:Number, data:VOPlayerState) 
		{ 
			super(type, false, false);
			this.data = data;
			this.vehicleID = vehicleId;
			
		} 
		
		public override function clone():Event 
		{ 
			return new EntryInfoChangeEvent(type, vehicleID, data);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("EntryInfoChangeEvent", "type", "vehicleId", "data"); 
		}
		
	}
	
}