package com.xvm.battle.minimap.entries.vehicle 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author s_sorochich
	 */
	public class UI_StrategicCameraEntry extends StrategicCameraEntry 
	{
		
		public function UI_StrategicCameraEntry() 
		{

			var testTF:TextField = new TextField();
			
			var format:TextFormat = new TextFormat();
			format.size = 15;
			format.color = 0xff0000;
			testTF.text = "ASS";
			testTF.setTextFormat(format);
			testTF.text = "ASS";
			
			testTF.x = width - testTF.width>>1;
			testTF.y = height - testTF.height>>1;
			addChild(testTF);
		}
		
	}

}