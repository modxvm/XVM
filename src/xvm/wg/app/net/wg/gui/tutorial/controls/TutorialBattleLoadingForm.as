package net.wg.gui.tutorial.controls
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import scaleform.clik.controls.StatusIndicator;
   import net.wg.gui.components.icons.BattleTypeIcon;


   public class TutorialBattleLoadingForm extends UIComponent
   {
          
      public function TutorialBattleLoadingForm() {
         super();
      }

      public var mapText:TextField;

      public var battleText:TextField;

      public var loadingBar:StatusIndicator;

      public var battleIcon:BattleTypeIcon = null;

      override protected function configUI() : void {
         super.configUI();
      }

      public function updateProgress(param1:Number) : void {
         this.loadingBar.position = param1;
      }

      public function updateMapName(param1:String) : void {
         this.mapText.text = param1?param1.toUpperCase():"";
      }

      public function updateBattleType(param1:String) : void {
         this.battleText.text = param1;
      }
   }

}