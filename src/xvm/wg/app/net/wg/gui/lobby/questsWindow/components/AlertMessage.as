package net.wg.gui.lobby.questsWindow.components
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   import flash.text.TextField;


   public class AlertMessage extends UIComponent
   {
          
      public function AlertMessage() {
         super();
      }

      private static const ICON_PADDING:int = 5;

      public var alertIcon:MovieClip;

      public var alertTF:TextField;

      override protected function configUI() : void {
         super.configUI();
         this.alertTF.text = QUESTS.QUESTS_CONTENT_NOQUESTSINROAMING;
      }

      override protected function onDispose() : void {
         this.alertIcon = null;
         this.alertTF = null;
         super.onDispose();
      }

      override protected function draw() : void {
         super.draw();
         this.alertIcon.x = Math.round((this.alertTF.width - this.alertTF.textWidth) / 2 - this.alertIcon.width + ICON_PADDING);
      }
   }

}