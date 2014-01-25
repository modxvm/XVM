package net.wg.gui.lobby.settings
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.infrastructure.interfaces.ISettingsBase;
   import net.wg.gui.components.controls.LabelControl;
   import flash.text.TextField;
   import net.wg.gui.components.controls.CheckBox;
   import flash.display.InteractiveObject;


   public class SettingsBaseView extends UIComponent implements IViewStackContent, ISettingsBase
   {
          
      public function SettingsBaseView() {
         super();
      }

      protected var _data:Object = null;

      protected var _viewId:String = "";

      override protected function configUI() : void {
         super.configUI();
         if(this._data)
         {
            this.setData(this._data);
         }
      }

      protected function trySetLabel(param1:String, param2:String="") : void {
         var _loc3_:String = null;
         var _loc4_:LabelControl = null;
         var _loc5_:TextField = null;
         var _loc6_:CheckBox = null;
         if(this._data[param1])
         {
            _loc3_ = "";
            if(this._data[param1].current != null)
            {
               _loc3_ = SettingsConfig.LOCALIZATION + param2 + param1;
            }
            if((this._data[param1].hasLabel) && (this[param1 + SettingsConfig.TYPE_LABEL]))
            {
               if(this[param1 + SettingsConfig.TYPE_LABEL]  is  LabelControl)
               {
                  _loc4_ = this[param1 + SettingsConfig.TYPE_LABEL];
                  _loc4_.text = _loc3_;
               }
               else
               {
                  _loc5_ = this[param1 + SettingsConfig.TYPE_LABEL];
                  _loc5_.text = _loc3_;
               }
            }
            else
            {
               if((this[param1 + SettingsConfig.TYPE_CHECKBOX]) && this[param1 + SettingsConfig.TYPE_CHECKBOX].label == "")
               {
                  _loc6_ = this[param1 + SettingsConfig.TYPE_CHECKBOX];
                  _loc6_.label = _loc3_;
               }
            }
         }
      }

      public function update(param1:Object) : void {
         this._viewId = param1.id;
         this._data = param1.data;
         if(this.initialized)
         {
            this.setData(this._data);
         }
      }

      protected function setData(param1:Object) : void {
          
      }

      public function updateDependentData() : void {
          
      }

      override protected function onDispose() : void {
         super.onDispose();
         this._data = null;
         this._viewId = null;
      }

      public function getComponentForFocus() : InteractiveObject {
         return null;
      }
   }

}