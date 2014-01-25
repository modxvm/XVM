package net.wg.gui.tutorial.controls
{
   import scaleform.clik.controls.ListItemRenderer;
   import flash.display.MovieClip;
   import flash.text.TextFieldAutoSize;
   import scaleform.clik.constants.InvalidationType;


   public class ChapterProgressItemRenderer extends ListItemRenderer
   {
          
      public function ChapterProgressItemRenderer() {
         super();
      }

      private static const STATE_DONE:String = "done";

      private static const STATE_FAILED:String = "failed";

      private static const TEXT_DELIMETER_STEP:Number = 4;

      public var resultIcon:MovieClip;

      public var textDelimeter:MovieClip;

      override protected function configUI() : void {
         super.configUI();
         textField.autoSize = TextFieldAutoSize.LEFT;
         buttonMode = useHandCursor = false;
      }

      override protected function draw() : void {
         var _loc1_:* = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(_data)
            {
               visible = true;
               _loc1_ = Math.min(Math.ceil(textField.textWidth / TEXT_DELIMETER_STEP) + 1,this.textDelimeter.totalFrames);
               this.textDelimeter.gotoAndStop(_loc1_);
               this.resultIcon.gotoAndStop(_data.done?STATE_DONE:STATE_FAILED);
            }
            else
            {
               visible = false;
            }
         }
      }

      override public function setData(param1:Object) : void {
         super.data = param1;
         invalidate(InvalidationType.DATA);
      }
   }

}