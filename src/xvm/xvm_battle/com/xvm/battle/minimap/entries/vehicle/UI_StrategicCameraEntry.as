package com.xvm.battle.minimap.entries.vehicle 
{
	import com.xfw.Logger;
	import com.xvm.Config;
	import com.xvm.Macros;
	import com.xvm.Utils;
	import com.xvm.wg.ImageWG;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.setInterval;

	public class UI_StrategicCameraEntry extends StrategicCameraEntry 
	{
		private var _loader:ImageWG;
		private var _aimScale:Number;
		private var _previousVisible: Boolean = false;
		private var _previousScale: Number;
		
		public function UI_StrategicCameraEntry() 
		{
			_loader = new ImageWG();
			_loader.successCallback = onImageSuccessLoadHandler;
			_loader.errorCallback = onImageFaultLoadHandler;		
		}
		
		
		override protected function configUI():void{
			super.configUI();
			var iconPath : String = Config.config.minimap.minimapAimIcon;
			_aimScale = Macros.FormatNumberGlobal(Config.config.minimap.minimapAimIconScale) / 100;
			if (iconPath)
			{
				iconPath = Utils.fixImgTagSrc(Macros.FormatStringGlobal(iconPath));
				_loader.source = iconPath;
			} 
			
		}
		
		private function onImageSuccessLoadHandler():void {
			parent.addChild(_loader);
			_loader.visible = false;
			_previousScale = _loader.parent.scaleX;
			_loader.scaleX = 1/_loader.parent.scaleX* _aimScale;
			_loader.scaleY = 1 / _loader.parent.scaleY * _aimScale;
			App.stage.addEventListener(Event.ENTER_FRAME, enterFrame, false, 0, true);

		}
		
		private function enterFrame():void 
		{
			_loader.x = x - _loader.width / 2;
			_loader.y = y - _loader.height / 2;

			if(visible!=_previousVisible){
				_loader.visible = visible;
				_previousVisible = visible;
			}
			
			if(_previousScale != _loader.parent.scaleX){
				
				_previousScale = _loader.parent.scaleX;
				_loader.scaleX = 1/_loader.parent.scaleX * _aimScale;
				_loader.scaleY = 1 / _loader.parent.scaleY * _aimScale;
			}
		}

		private function onImageFaultLoadHandler():void {

		   Logger.add("Can't resolve path: " + Config.config.minimap.minimapAimIcon);
		}
					
		override protected function onDispose() : void {
			App.stage.removeEventListener(Event.ENTER_FRAME, enterFrame);	
			_loader.dispose();
			if(_loader.parent){
				_loader.parent.removeChild(_loader);
			}
			
			super.onDispose();
		}
	}

}