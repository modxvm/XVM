package net.wg.gui.lobby.header 
{
    import flash.display.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    
    public class AccountInfo extends scaleform.clik.core.UIComponent
    {
        public function AccountInfo()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            this.premiumBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onPremiumBtnClickHndlr);
            this.goldExchangeBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.showExchange);
            this.accountRefillBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onPaymentBtnClick);
            this.expGatheringBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onGatheringXPBtnClick);
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.premiumBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onPremiumBtnClickHndlr);
            this.goldExchangeBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.showExchange);
            this.accountRefillBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onPaymentBtnClick);
            this.expGatheringBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onGatheringXPBtnClick);
            return;
        }

        public function setProfileType(arg1:String):void
        {
            this.premiumBtn.label = MENU.COMMON_PREMIUMBUY;
            this.premiumBtn.tooltip = TOOLTIPS.HEADER_PREMIUM_BUY;
            this.premiumBtn.enabled = true;
            this.premium_info.textField.htmlText = arg1;
            return;
        }

        public function setPremiumParams(arg1:String, arg2:String, arg3:Boolean):void
        {
            this.premiumBtn.label = arg2;
            this.premiumBtn.tooltip = TOOLTIPS.HEADER_PREMIUM_EXTEND;
            this.premiumBtn.enabled = !arg3;
            this.premium_info.textField.htmlText = this.premium_info.textField.htmlText + (" " + arg1);
            return;
        }

        public function setExp(arg1:String):void
        {
            this.experience.text = arg1;
            return;
        }

        public function setCredits(arg1:String):void
        {
            this.credits.text = arg1;
            return;
        }

        public function setGold(arg1:String):void
        {
            this.gold.text = arg1;
            return;
        }

        public function onPremiumChange(arg1:Boolean):void
        {
            this.m_isPremium = arg1;
            return;
        }

        public function disablePaymentButon(arg1:Boolean):void
        {
            this.accountRefillBtn.enabled = arg1;
            return;
        }

        public function onPaymentBtnClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            dispatchEvent(new net.wg.gui.events.HeaderEvent(net.wg.gui.events.HeaderEvent.PAYMENT_BTN_CLICK));
            return;
        }

        public function showExchange(arg1:scaleform.clik.events.ButtonEvent):void
        {
            dispatchEvent(new net.wg.gui.events.HeaderEvent(net.wg.gui.events.HeaderEvent.SHOW_EXCHANGE));
            return;
        }

        public function onGatheringXPBtnClick(arg1:Object):void
        {
            dispatchEvent(new net.wg.gui.events.HeaderEvent(net.wg.gui.events.HeaderEvent.SHOW_XP_EXCHANGE));
            return;
        }

        public function onPremiumBtnClickHndlr(arg1:scaleform.clik.events.ButtonEvent):void
        {
            dispatchEvent(new net.wg.gui.events.HeaderEvent(net.wg.gui.events.HeaderEvent.SHOW_PREMIUM));
            return;
        }

        public var premium_info:flash.display.MovieClip;

        public var gold:net.wg.gui.components.controls.IconText;

        public var credits:net.wg.gui.components.controls.IconText;

        public var experience:net.wg.gui.components.controls.IconText;

        public var premiumBtn:net.wg.gui.components.controls.IconTextButton;

        public var accountRefillBtn:net.wg.gui.components.controls.IconTextButton;

        public var goldExchangeBtn:net.wg.gui.components.controls.IconTextButton;

        public var expGatheringBtn:net.wg.gui.components.controls.IconTextButton;

        internal var m_isPremium:Boolean=false;

        public var steamPackets:Array;
    }
}
