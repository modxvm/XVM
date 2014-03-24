package net.wg.gui.lobby.settings.components
{
   import net.wg.gui.components.controls.StepSlider;
   import flash.events.MouseEvent;


   public class SettingsStepSlider extends StepSlider
   {
          
      public function SettingsStepSlider() {
         super();
      }

      private var _inAdvancedMode:Boolean = true;

      override protected function onScrollWheel(param1:MouseEvent) : void {
          
      }

      override protected function checkIsItemDisabled(param1:Object) : Boolean {
         var _loc2_:* = false;
         if(!this._inAdvancedMode && (param1.hasOwnProperty("advanced")))
         {
            _loc2_ = param1["advanced"];
         }
         return _loc2_;
      }

      override protected function getItemTooltip(param1:Object) : String {
         return App.utils.locale.makeString(getItemLabel(param1));
      }

      public function get inAdvancedMode() : Boolean {
         return this._inAdvancedMode;
      }

      public function set inAdvancedMode(param1:Boolean) : void {
         this._inAdvancedMode = param1;
         invalidateData();
      }
   }

}