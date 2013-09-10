package net.wg.gui.tutorial.controls 
{
    import flash.display.*;
    import flash.text.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    
    public class ChapterProgressItemRenderer extends scaleform.clik.controls.ListItemRenderer
    {
        public function ChapterProgressItemRenderer()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            var loc1:*;
            useHandCursor = loc1 = false;
            buttonMode = loc1;
            return;
        }

        protected override function draw():void
        {
            var loc1:*=0;
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                if (_data) 
                {
                    visible = true;
                    loc1 = Math.min(Math.ceil(textField.textWidth / TEXT_DELIMETER_STEP) + 1, this.textDelimeter.totalFrames);
                    this.textDelimeter.gotoAndStop(loc1);
                    this.resultIcon.gotoAndStop(_data.done ? STATE_DONE : STATE_FAILED);
                }
                else 
                {
                    visible = false;
                }
            }
            return;
        }

        public override function setData(arg1:Object):void
        {
            super.data = arg1;
            invalidate(scaleform.clik.constants.InvalidationType.DATA);
            return;
        }

        internal static const STATE_DONE:String="done";

        internal static const STATE_FAILED:String="failed";

        internal static const TEXT_DELIMETER_STEP:Number=4;

        public var resultIcon:flash.display.MovieClip;

        public var textDelimeter:flash.display.MovieClip;
    }
}
