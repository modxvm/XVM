package net.wg.gui.components.tooltips 
{
    import flash.display.*;
    import flash.text.*;
    
    public class IgrQuestBlock extends flash.display.MovieClip
    {
        public function IgrQuestBlock()
        {
            super();
            return;
        }

        public function setText(arg1:String):void
        {
            this.questText.htmlText = arg1;
            this.questText.width = this.questText.textWidth;
            return;
        }

        public var questText:flash.text.TextField;
    }
}
