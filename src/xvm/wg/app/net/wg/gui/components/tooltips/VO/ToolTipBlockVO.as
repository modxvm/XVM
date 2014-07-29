package net.wg.gui.components.tooltips.VO
{
    import flash.display.MovieClip;
    import flash.text.StyleSheet;
    
    public class ToolTipBlockVO extends Object
    {
        
        public function ToolTipBlockVO()
        {
            super();
        }
        
        public var contener:MovieClip = null;
        
        public var startYPos:Number = 0;
        
        public var childrenNamePrefix:String = "";
        
        public var header:String = "";
        
        public var leftText:String = "";
        
        public var leftTextColor:Number = 16777215;
        
        public var rightTextList:Vector.<ToolTipBlockRightListItemVO> = null;
        
        public var rightTextColor:Number = 16777215;
        
        public var rightTextCSS:StyleSheet = null;
    }
}
