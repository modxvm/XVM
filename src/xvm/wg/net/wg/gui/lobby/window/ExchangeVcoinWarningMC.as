package net.wg.gui.lobby.window 
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.utils.*;
    import scaleform.clik.core.*;
    
    public class ExchangeVcoinWarningMC extends scaleform.clik.core.UIComponent
    {
        public function ExchangeVcoinWarningMC()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this.textField.wordWrap = true;
            this.textField.multiline = true;
            var loc1:*=App.utils.locale;
            this.buyVcoinBtn.label = loc1.makeString(MENU.EXCHANGEVCOIN_BUYVCOINBTNNAME);
            return;
        }

        public function set minTransactValue(arg1:Number):void
        {
            var loc1:*=App.utils.locale;
            this.textField.text = loc1.makeString(MENU.EXCHANGEVCOIN_VCOINISTIGHT, {"minval":arg1.toString()});
            this.buyVcoinBtn.y = Math.round(this.textField.y + this.textField.textHeight + BTN_OFFSET);
            this.bg.height = Math.round(this.buyVcoinBtn.y + this._contentPadding * 2);
            return;
        }

        public function get contentPadding():int
        {
            return this._contentPadding;
        }

        internal static const BTN_OFFSET:int=13;

        public var buyVcoinBtn:net.wg.gui.components.controls.SoundButtonEx;

        public var textField:flash.text.TextField;

        public var bg:flash.display.MovieClip;

        internal var _contentPadding:int=20;
    }
}
