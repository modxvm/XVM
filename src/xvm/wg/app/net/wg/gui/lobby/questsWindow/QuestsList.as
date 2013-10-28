package net.wg.gui.lobby.questsWindow
{
   import net.wg.gui.components.controls.ScrollingListEx;
   import flash.text.TextField;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;


   public class QuestsList extends ScrollingListEx
   {
          
      public function QuestsList() {
         super();
      }

      public var allQuestsDoneTF:TextField;

      public var clickCheckboxTF:TextField;

      override protected function configUI() : void {
         super.configUI();
         this.allQuestsDoneTF.text = QUESTS.QUESTS_LIST_COMPLETE;
         this.clickCheckboxTF.text = QUESTS.QUESTS_LIST_CLICKCHECKBOX;
      }

      override protected function drawLayout() : void {
         var _loc8_:IListItemRenderer = null;
         var _loc1_:uint = _renderers.length;
         var _loc2_:Number = rowHeight;
         var _loc3_:Number = availableWidth - padding.horizontal;
         var _loc4_:Number = margin + padding.left;
         var _loc5_:Number = margin + padding.top;
         var _loc6_:Boolean = isInvalid(InvalidationType.DATA);
         var _loc7_:uint = 0;
         while(_loc7_ < _loc1_)
         {
            _loc8_ = getRendererAt(_loc7_);
            _loc8_.x = Math.round(_loc4_);
            _loc8_.y = Math.round(_loc5_ + _loc7_ * _loc2_);
            if(!_loc6_)
            {
               _loc8_.validateNow();
            }
            _loc7_++;
         }
         drawScrollBar();
      }

      override public function set dataProvider(param1:IDataProvider) : void {
         super.dataProvider = param1;
         if((dataProvider) && dataProvider.length > 0)
         {
            this.allQuestsDoneTF.visible = false;
            this.clickCheckboxTF.visible = false;
         }
         else
         {
            this.allQuestsDoneTF.visible = true;
            this.clickCheckboxTF.visible = true;
         }
      }

      override public function dispose() : void {
         super.dispose();
      }

      override protected function updateSelectedIndex() : void {
         super.updateSelectedIndex();
         App.utils.focusHandler.setFocus(this);
      }
   }

}