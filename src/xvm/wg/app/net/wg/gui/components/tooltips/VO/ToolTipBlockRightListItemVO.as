package net.wg.gui.components.tooltips.VO 
{
    public class ToolTipBlockRightListItemVO extends Object
    {
        public function ToolTipBlockRightListItemVO(arg1:String="", arg2:String=null, arg3:Number=0, arg4:Number=0)
        {
            super();
            this.text = arg1;
            this.icon = arg2;
            this.textYOffset = arg3;
            this.textXOffset = arg4;
            return;
        }

        public var text:String=null;

        public var icon:String=null;

        public var textYOffset:Number=NaN;

        public var textXOffset:Number=NaN;
    }
}
