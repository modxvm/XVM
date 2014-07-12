package net.wg.gui.tutorial.windows
{
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.tutorial.controls.BattleBonusItem;
   import flash.text.TextField;
   import flash.display.InteractiveObject;
   
   public class TutorialGreetingDialog extends TutorialDialog
   {
      
      public function TutorialGreetingDialog() {
         super();
         canClose = false;
         canDrag = false;
         isModal = true;
      }
      
      public var imageLoader:UILoaderAlt;
      
      public var bonusItem:BattleBonusItem;
      
      public var timeField:TextField;
      
      public var restartHintField:TextField;
      
      override protected function drawData() : void {
         super.drawData();
         this.imageLoader.source = _data.imageUrl;
         messageField.htmlText = _data.message;
         this.timeField.htmlText = _data.timeNoteValue;
         this.updateBonuses();
      }
      
      private function updateBonuses() : void {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:* = 0;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc1_:Array = _data?_data.bonuses:null;
         if((this.bonusItem) && (_loc1_))
         {
            _loc2_ = 0;
            _loc3_ = 0;
            _loc4_ = 0;
            while(_loc4_ < _loc1_.length)
            {
               _loc5_ = _loc1_[_loc4_];
               if(!Boolean(_loc5_.received))
               {
                  _loc6_ = _loc5_.values;
                  if(_loc6_.credits)
                  {
                     _loc2_ = _loc2_ + Number(_loc6_.credits);
                  }
                  if(_loc6_.freeXP)
                  {
                     _loc3_ = _loc3_ + Number(_loc6_.freeXP);
                  }
               }
               _loc4_++;
            }
            this.bonusItem.setBonuses(_loc2_,_loc3_);
         }
      }
      
      override protected function configUI() : void {
         super.configUI();
         this.restartHintField.text = App.utils.locale.makeString(BATTLE_TUTORIAL.DIALOGS_GREETING_RESTART_HINT_TEXT);
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void {
         super.onInitModalFocus(param1);
         setFocus(submitBtn);
      }
      
      override protected function onPopulate() : void {
         super.onPopulate();
         window.useBottomBtns = true;
         window.title = BATTLE_TUTORIAL.DIALOGS_GREETING_TITLE;
      }
      
      override protected function onDispose() : void {
         super.onDispose();
         this.imageLoader.dispose();
      }
   }
}
