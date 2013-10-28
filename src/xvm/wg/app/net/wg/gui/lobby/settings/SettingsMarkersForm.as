package net.wg.gui.lobby.settings
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import flash.events.Event;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ListEvent;
   import net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent;


   public class SettingsMarkersForm extends UIComponent
   {
          
      public function SettingsMarkersForm() {
         super();
      }

      private var _id:String = null;

      private var _data:Object = null;

      public var markerHeader:TextField = null;

      public var markerHP:TextField = null;

      public var markerHeaderAlt:TextField = null;

      public var markerHPAlt:TextField = null;

      public var markerBaseIconCheckbox:CheckBox = null;

      public var markerBaseLevelCheckbox:CheckBox = null;

      public var markerBaseVehicleNameCheckbox:CheckBox = null;

      public var markerBasePlayerNameCheckbox:CheckBox = null;

      public var markerBaseHpIndicatorCheckbox:CheckBox = null;

      public var markerBaseHpDropDown:DropdownMenu = null;

      public var markerBaseDamageCheckbox:CheckBox = null;

      public var markerAltIconCheckbox:CheckBox = null;

      public var markerAltLevelCheckbox:CheckBox = null;

      public var markerAltVehicleNameCheckbox:CheckBox = null;

      public var markerAltPlayerNameCheckbox:CheckBox = null;

      public var markerAltHpIndicatorCheckbox:CheckBox = null;

      public var markerAltHpDropDown:DropdownMenu = null;

      public var markerAltDamageCheckbox:CheckBox = null;

      override protected function configUI() : void {
         super.configUI();
      }

      override protected function draw() : void {
         super.draw();
      }

      public function setData(param1:String, param2:Object) : void {
         var _loc3_:String = null;
         var _loc4_:SettingsControlProp = null;
         var _loc5_:CheckBox = null;
         var _loc6_:DropdownMenu = null;
         this._id = param1;
         if(param2 != null)
         {
            this._data = param2;
            for (_loc3_ in this._data)
            {
               _loc4_ = SettingsControlProp(this._data[_loc3_]);
               if(this[_loc3_ + _loc4_.type])
               {
                  switch(_loc4_.type)
                  {
                     case SettingsConfig.TYPE_CHECKBOX:
                        _loc5_ = this[_loc3_ + _loc4_.type];
                        _loc5_.selected = _loc4_.current;
                        _loc5_.addEventListener(Event.SELECT,this.onCheckBoxSelected);
                        continue;
                     case SettingsConfig.TYPE_DROPDOWN:
                        _loc6_ = this[_loc3_ + _loc4_.type];
                        _loc6_.menuRowCount = _loc4_.options.length;
                        _loc6_.dataProvider = new DataProvider(_loc4_.options);
                        _loc6_.selectedIndex = _loc4_.current;
                        _loc6_.enabled = _loc4_.current == null?false:true;
                        _loc6_.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownChange);
                        continue;
                     default:
                        continue;
                  }
               }
               else
               {
                  continue;
               }
            }
         }
         else
         {
            this.disableAllControls();
         }
      }

      private function onDropDownChange(param1:ListEvent) : void {
         var _loc2_:DropdownMenu = DropdownMenu(param1.target);
         var _loc3_:String = SettingsConfig.getControlId(_loc2_.name,SettingsConfig.TYPE_DROPDOWN);
         var _loc4_:String = this.getAltPrefix(_loc3_);
         dispatchEvent(new SettingsSubVewEvent(SettingsSubVewEvent.ON_CONTROL_CHANGE,this._id,_loc3_,_loc2_.selectedIndex,_loc4_));
      }

      private function onCheckBoxSelected(param1:Event) : void {
         var _loc2_:CheckBox = CheckBox(param1.target);
         var _loc3_:String = SettingsConfig.getControlId(_loc2_.name,SettingsConfig.TYPE_CHECKBOX);
         var _loc4_:String = this.getAltPrefix(_loc3_);
         dispatchEvent(new SettingsSubVewEvent(SettingsSubVewEvent.ON_CONTROL_CHANGE,this._id,_loc3_,_loc2_.selected,_loc4_));
      }

      private function getAltPrefix(param1:String) : String {
         return param1.indexOf("Alt",0) >= 0?"Alt":"";
      }

      private function disableAllControls() : void {
         this.markerBaseIconCheckbox.enabled = false;
         this.markerBaseLevelCheckbox.enabled = false;
         this.markerBaseVehicleNameCheckbox.enabled = false;
         this.markerBasePlayerNameCheckbox.enabled = false;
         this.markerBaseHpIndicatorCheckbox.enabled = false;
         this.markerBaseHpDropDown.enabled = false;
         this.markerBaseDamageCheckbox.enabled = false;
         this.markerAltIconCheckbox.enabled = false;
         this.markerAltLevelCheckbox.enabled = false;
         this.markerAltVehicleNameCheckbox.enabled = false;
         this.markerAltPlayerNameCheckbox.enabled = false;
         this.markerAltHpIndicatorCheckbox.enabled = false;
         this.markerAltHpDropDown.enabled = false;
         this.markerAltDamageCheckbox.enabled = false;
      }

      override public function dispose() : void {
         var _loc1_:String = null;
         var _loc2_:SettingsControlProp = null;
         var _loc3_:CheckBox = null;
         var _loc4_:DropdownMenu = null;
         if(this._data != null)
         {
            for (_loc1_ in this._data)
            {
               _loc2_ = SettingsControlProp(this._data[_loc1_]);
               if(this[_loc1_ + _loc2_.type])
               {
                  switch(_loc2_.type)
                  {
                     case SettingsConfig.TYPE_CHECKBOX:
                        _loc3_ = this[_loc1_ + _loc2_.type];
                        if(_loc3_.hasEventListener(Event.SELECT))
                        {
                           _loc3_.removeEventListener(Event.SELECT,this.onCheckBoxSelected);
                        }
                        continue;
                     case SettingsConfig.TYPE_DROPDOWN:
                        _loc4_ = this[_loc1_ + _loc2_.type];
                        if(_loc4_.hasEventListener(ListEvent.INDEX_CHANGE))
                        {
                           _loc4_.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropDownChange);
                        }
                        continue;
                     default:
                        continue;
                  }
               }
               else
               {
                  continue;
               }
            }
            this._data = null;
         }
         super.dispose();
      }
   }

}