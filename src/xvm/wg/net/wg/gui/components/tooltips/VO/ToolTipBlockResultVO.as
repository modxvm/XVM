package net.wg.gui.components.tooltips.VO 
{
    import __AS3__.vec.*;
    import flash.text.*;
    
    public class ToolTipBlockResultVO extends Object
    {
        public function ToolTipBlockResultVO(arg1:Number, arg2:flash.text.TextField, arg3:__AS3__.vec.Vector.<net.wg.gui.components.controls.IconText>, arg4:Array, arg5:flash.text.TextField, arg6:Boolean, arg7:Number, arg8:Number)
        {
            super();
            this.startYPos = arg1;
            this.leftTextField = arg2;
            this.elRightList = arg3;
            this.centerList = arg4;
            this.headerTextField = arg5;
            this.hasIcons = arg6;
            this.leftPartMaxW = arg7;
            this.blockWidth = arg8;
            return;
        }

        public var startYPos:Number=NaN;

        public var leftTextField:flash.text.TextField=null;

        public var elRightList:__AS3__.vec.Vector.<net.wg.gui.components.controls.IconText>=null;

        public var centerList:Array=null;

        public var headerTextField:flash.text.TextField=null;

        public var hasIcons:Boolean=false;

        public var leftPartMaxW:Number=NaN;

        public var blockWidth:Number=NaN;
    }
}
