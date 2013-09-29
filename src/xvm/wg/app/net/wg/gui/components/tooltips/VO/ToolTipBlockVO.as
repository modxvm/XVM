package net.wg.gui.components.tooltips.VO 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.text.*;
    
    public class ToolTipBlockVO extends Object
    {
        public function ToolTipBlockVO()
        {
            super();
            return;
        }

        public var contener:flash.display.MovieClip=null;

        public var startYPos:Number=0;

        public var childrenNamePrefix:String="";

        public var header:String="";

        public var leftText:String="";

        public var leftTextColor:Number=16777215;

        public var rightTextList:__AS3__.vec.Vector.<net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO>=null;

        public var rightTextColor:Number=16777215;

        public var rightTextCSS:flash.text.StyleSheet=null;
    }
}
