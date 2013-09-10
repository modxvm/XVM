package net.wg.gui.lobby.questsWindow 
{
    import flash.display.*;
    import flash.text.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class DescriptionBlock extends scaleform.clik.core.UIComponent
    {
        public function DescriptionBlock()
        {
            super();
            return;
        }

        public function setLabels(arg1:String, arg2:String):void
        {
            this._title = arg1;
            this._descr = arg2;
            invalidateData();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=NaN;
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.lableTF.text = this._title;
                this.descrTF.text = this._descr;
                this.descrTF.y = Math.round(this.lableTF.y + this.lableTF.textHeight + 3);
                this.lineMC.y = Math.round(this._descr ? this.descrTF.y + this.descrTF.textHeight : this.lableTF.y + this.lableTF.textHeight) + BOTTOM_PADDING;
                loc1 = Math.round(this.lineMC.y + this.lineMC.height);
                setSize(this.width, loc1);
            }
            return;
        }

        public override function dispose():void
        {
            this.lableTF = null;
            this.descrTF = null;
            this.lineMC = null;
            super.dispose();
            return;
        }

        internal static const BOTTOM_PADDING:int=20;

        public var lableTF:flash.text.TextField;

        public var descrTF:flash.text.TextField;

        public var lineMC:flash.display.MovieClip;

        internal var _title:String="";

        internal var _descr:String="";
    }
}
