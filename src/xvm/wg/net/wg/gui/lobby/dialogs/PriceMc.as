package net.wg.gui.lobby.dialogs 
{
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.profile.components.*;
    import scaleform.clik.core.*;
    
    public class PriceMc extends scaleform.clik.core.UIComponent
    {
        public function PriceMc()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.dashLine.width = 305;
            this.normalTextColor = this.priceValue.textColor;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(OPERATION_INVALID)) 
            {
                this.priceValue.textColor = this._allowed ? this.normalTextColor : 16711680;
            }
            return;
        }

        public function set allowed(arg1:Boolean):void
        {
            this._allowed = arg1;
            invalidate(OPERATION_INVALID);
            return;
        }

        internal static const OPERATION_INVALID:String="opInv";

        public var dashLine:net.wg.gui.lobby.profile.components.DashLine;

        public var textField:flash.text.TextField;

        public var priceValue:net.wg.gui.components.controls.IconText;

        internal var _allowed:Boolean=true;

        internal var normalTextColor:uint=0;
    }
}
