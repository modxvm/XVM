package net.wg.gui.components.tooltips.finstats 
{
    import flash.text.*;
    import scaleform.clik.core.*;
    
    public class EfficiencyBlock extends scaleform.clik.core.UIComponent
    {
        public function EfficiencyBlock()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (this.dirtyData) 
            {
                this.leftTF.autoSize = flash.text.TextFieldAutoSize.RIGHT;
                this.leftTF.multiline = true;
                this.leftTF.wordWrap = true;
                this.leftTF.htmlText = this._leftStr;
                this.leftTF.width = Math.max(this.leftTF.textWidth + 5, 60);
                this.leftTF.height = this.leftTF.textHeight + 4;
                this.rightTF.autoSize = flash.text.TextFieldAutoSize.LEFT;
                this.rightTF.multiline = true;
                this.rightTF.wordWrap = true;
                this.rightTF.htmlText = this._rightStr;
                this.rightTF.x = this.leftTF.x + this.leftTF.width + 5;
                this.rightTF.width = this.rightTF.textWidth + 5;
                this.rightTF.height = this.rightTF.textHeight + 4;
            }
            return;
        }

        public function setData(arg1:String, arg2:String):void
        {
            this._leftStr = arg1;
            this._rightStr = arg2;
            this.dirtyData = true;
            validateNow();
            return;
        }

        public var leftTF:flash.text.TextField;

        public var rightTF:flash.text.TextField;

        internal var dirtyData:Boolean=false;

        internal var _leftStr:String="";

        internal var _rightStr:String="";
    }
}
