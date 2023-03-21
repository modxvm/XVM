/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */

package com.xvm.vehiclemarkers.ui.components
{
	import com.xvm.Macros;
	import com.xvm.Utils;
	import com.xvm.battle.vo.VOPlayerState;
	import com.xvm.types.cfg.CMarkersVehicleDist;
	import com.xvm.types.cfg.CTextFormat;
	import com.xvm.vehiclemarkers.ui.XvmVehicleMarker;
	import com.xvm.vehiclemarkers.ui.XvmVehicleMarkerEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import scaleform.gfx.TextFieldEx;
	
	public final class VehicleDistComponent extends VehicleMarkerComponentBase implements IVehicleMarkerComponent
	{
		private var text:String         = "";
		private var textField:TextField = null;
		private var cfg:CMarkersVehicleDist;
		private var isAlive:Boolean;
		
		public final function VehicleDistComponent(marker:XvmVehicleMarker)
		{
			super(marker);
		}
		
		override protected function onDispose():void
		{
			if (textField)
			{
				marker.removeChild(textField);
				textField = null;
			}
			super.onDispose();
		}
		
		public final function init(e:XvmVehicleMarkerEvent):void
		{
			cfg = e.cfg.vehicleDist;
			isAlive = e.playerState.isAlive;
			if (!(cfg && cfg.enabled))
			{
				return;
			}
			
			if (!this.initialized)
			{
				this.initialized = true;
				textField = new TextField();
				marker.addChild(textField);
				textField.mouseEnabled = false;
				textField.selectable = false;
				TextFieldEx.setNoTranslate(textField, true);
				textField.antiAliasType = AntiAliasType.ADVANCED;
				textField.multiline = true;
				textField.wordWrap = false;
				textField.y = 0;
				textField.width = 100;
				textField.height = 100;
				settingTextField(e);
				textField.htmlText = text;
			}
		}
		
		public final function onExInfo(e:XvmVehicleMarkerEvent):void
		{
			update(e);
		}
		
		public final function update(e:XvmVehicleMarkerEvent):void
		{
			if (e.playerState)
			{
				isAlive = e.playerState.isAlive;
			}

			cfg = e.cfg.vehicleDist;
			if (cfg && cfg.enabled)
			{
				settingTextField(e);
			}
		}
		
		public function setDistance(dist:String):void
		{
			if (this.text == dist)
			{
				return;
			}
			this.text = dist;
			if (this.textField)
			{
				this.textField.htmlText = isAlive ? dist : "";
			}
		}
		
		private function settingTextField(e:XvmVehicleMarkerEvent):void
		{
			if (!textField)
			{
				return;
			}
			
			var playerState:VOPlayerState = e.playerState;
			textField.x = Macros.FormatNumber(cfg.x, playerState, 0);
			textField.y = Macros.FormatNumber(cfg.y, playerState, -66);
			textField.alpha = Macros.FormatNumber(cfg.alpha, playerState, 1) / 100.0;
			if (!cfg.textFormat)
			{
				cfg.textFormat = CTextFormat.GetDefaultConfigForMarkers();
				cfg.textFormat.color = 0xFFFFFF;
			}
			textField.defaultTextFormat = Utils.createTextFormatFromConfig(cfg.textFormat, playerState);
			textField.filters = Utils.createShadowFiltersFromConfig(cfg.shadow, playerState);
			textField.x -= (textField.width / 2.0);
		}
	}
}