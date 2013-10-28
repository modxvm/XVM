package net.wg.gui.tutorial.windows
{
   import net.wg.gui.tutorial.meta.impl.TutorialBattleNoResultsMeta;
   import net.wg.gui.tutorial.meta.ITutorialBattleNoResultsMeta;
   import flash.text.TextField;
   import scaleform.clik.constants.InvalidationType;


   public class TutorialBattleNoResultsWindow extends TutorialBattleNoResultsMeta implements ITutorialBattleNoResultsMeta
   {
          
      public function TutorialBattleNoResultsWindow() {
         super();
      }

      public var textField:TextField;

      protected var data:Object;

      override protected function configUI() : void {
         super.configUI();
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(InvalidationType.DATA)) && (this.data))
         {
            this.textField.text = this.data.text;
         }
      }

      override protected function onDispose() : void {
         super.onDispose();
         this.data = null;
      }

      public function as_setData(param1:Object) : void {
         this.data = param1;
         invalidate(InvalidationType.DATA);
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         window.useBottomBtns = false;
         window.title = BATTLE_TUTORIAL.WINDOWS_RESULT_TITLE;
      }
   }

}