package net.wg.gui.lobby.questsWindow.components
{
   import net.wg.gui.lobby.profile.components.DashLineTextItem;
   import flash.text.TextFieldAutoSize;
   import scaleform.clik.constants.InvalidationType;


   public class QuestsDashlineItem extends DashLineTextItem
   {
          
      public function QuestsDashlineItem() {
         super();
         dashLine.visible = false;
      }

      override protected function configUI() : void {
         super.configUI();
         dashLine.visible = false;
      }

      override protected function draw() : void {
         var _loc1_:* = NaN;
         if(isInvalid(VALUE_INV))
         {
            if(_myEnabled)
            {
               gotoAndPlay("up");
               valueTextField.autoSize = TextFieldAutoSize.LEFT;
               valueTextField.htmlText = value;
            }
            else
            {
               gotoAndPlay("disabled");
               valueTextField.autoSize = TextFieldAutoSize.LEFT;
               valueTextField.htmlText = "--";
            }
            if(isInvalid(LABEL_INV))
            {
               labelTextField.autoSize = TextFieldAutoSize.LEFT;
               labelTextField.text = label;
               labelTextField.width = _width - 20 - valueTextField.width;
               labelTextField.height = labelTextField.textHeight + 10;
               invalidate(InvalidationType.SIZE);
            }
            invalidate(InvalidationType.SIZE);
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = labelTextField.getLineMetrics(labelTextField.numLines-1).width;
            dashLine.width = Math.round(_width - _loc1_ - valueTextField.width - dashLinePadding * 2);
            dashLine.x = Math.round(_loc1_ + dashLinePadding * 2);
            dashLine.y = Math.round(labelTextField.textHeight - dashLine.height - dashLinePadding * 2);
            dashLine.validateNow();
            valueTextField.x = Math.round(_width - valueTextField.width);
            valueTextField.y = Math.round(labelTextField.textHeight - valueTextField.textHeight);
            valueTextField.visible = dashLine.visible = Boolean(value);
         }
      }
   }

}