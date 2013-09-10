package net.wg.gui.lobby.window 
{
    import fl.transitions.easing.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.utils.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.clik.motion.*;
    import scaleform.clik.utils.*;
    
    public class ExchangeVcoinWindow extends net.wg.gui.lobby.window.ExchangeCurrencyWindow implements net.wg.infrastructure.base.meta.IExchangeVcoinWindowMeta
    {
        public function ExchangeVcoinWindow()
        {
            this.animationManager = new net.wg.gui.utils.ExcludeTweenManager();
            super();
            this.tweenSet = {};
            this.tweenSet.ease = fl.transitions.easing.Strong.easeOut;
            this.tweenSet.onComplete = this.onTweenComplete;
            return;
        }

        public function buyVcoinS():void
        {
            App.utils.asserter.assertNotNull(this.buyVcoin, "exchange" + net.wg.data.constants.Errors.CANT_NULL);
            this.buyVcoin();
            return;
        }

        public function as_setTargetCurrencyData(arg1:Object):void
        {
            this.exchangeData = new net.wg.gui.lobby.window.VcoinExchangeDataVO(arg1);
            exchangeStep = this.exchangeData.countStep;
            return;
        }

        public override function set window(arg1:net.wg.infrastructure.interfaces.IWindow):void
        {
            super.window = arg1;
            if (arg1) 
            {
                window.title = MENU.EXCHANGEVCOIN_TITLE;
                this.windowOriginalHeight = window.sourceView.height + window.contentPadding.vertical;
                invalidate(TOTAL_PRIMARY_CURRENCY_INVALID);
            }
            return;
        }

        protected override function preInitialize():void
        {
            super.preInitialize();
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.REFLOW);
            return;
        }

        protected override function configUI():void
        {
            var loc4:*=0;
            super.configUI();
            this.buyVcoinBtn.label = App.utils.locale.makeString(MENU.EXCHANGEVCOIN_BUYVCOINBTNNAME);
            this.warningMc.visible = false;
            var loc1:*=(this.warningMc.parent.getChildIndex(this.warningMc) - 1);
            var loc2:*=new flash.display.Sprite();
            addChildAt(loc2, loc1);
            loc2.addChild(lblToExchange);
            loc2.addChild(lblExchangeResult);
            loc2.addChild(resultPrimaryCurrencyText);
            loc2.addChild(resultSecondaryCurrencyText);
            loc2.addChild(toExchangePrimaryCurrencyIco);
            loc2.addChild(toExchangeSecondaryCurrencyIco);
            loc2.addChild(submitBtn);
            loc2.addChild(cancelBtn);
            loc2.addChild(this.buyVcoinBtn);
            loc2.name = "movingContainer";
            loc2.addChild(nsPrimaryCurrency);
            loc2.addChild(nsSecondaryCurrency);
            constraints.addElement(this.mainBackgroundMc.name, this.mainBackgroundMc, scaleform.clik.utils.Constraints.ALL);
            constraints.addElement(loc2.name, loc2, scaleform.clik.utils.Constraints.BOTTOM);
            onHandPrimaryCurrencyText.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(net.wg.gui.components.controls.IconText.VCOIN);
            onHandSecondaryCurrencyText.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(net.wg.gui.components.controls.IconText.GOLD);
            resultPrimaryCurrencyText.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(net.wg.gui.components.controls.IconText.VCOIN);
            resultSecondaryCurrencyText.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(net.wg.gui.components.controls.IconText.GOLD);
            toExchangePrimaryCurrencyIco.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(net.wg.gui.components.controls.IconText.VCOIN);
            toExchangeSecondaryCurrencyIco.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(net.wg.gui.components.controls.IconText.GOLD);
            resultPrimaryCurrencyText.icon = net.wg.gui.components.controls.IconText.VCOIN;
            resultSecondaryCurrencyText.icon = net.wg.gui.components.controls.IconText.GOLD;
            toExchangePrimaryCurrencyIco.icon = net.wg.gui.components.controls.IconText.VCOIN;
            toExchangeSecondaryCurrencyIco.icon = net.wg.gui.components.controls.IconText.GOLD;
            onHandPrimaryCurrencyText.icon = net.wg.gui.components.controls.IconText.VCOIN;
            onHandSecondaryCurrencyText.icon = net.wg.gui.components.controls.IconText.GOLD;
            var loc3:*=App.colorSchemeMgr.getRGB(net.wg.data.constants.ColorSchemeNames.TEXT_COLOR_VCOIN);
            loc4 = App.colorSchemeMgr.getRGB(net.wg.data.constants.ColorSchemeNames.TEXT_COLOR_GOLD);
            onHandPrimaryCurrencyText.textColor = loc3;
            onHandSecondaryCurrencyText.textColor = loc4;
            resultPrimaryCurrencyText.icon = net.wg.gui.components.controls.IconText.VCOIN;
            resultSecondaryCurrencyText.icon = net.wg.gui.components.controls.IconText.GOLD;
            resultPrimaryCurrencyText.textColor = loc3;
            resultSecondaryCurrencyText.textColor = loc4;
            nsPrimaryCurrency.textColor = loc3;
            nsSecondaryCurrency.textColor = loc4;
            headerMC.rate_part_1.icon = net.wg.gui.components.controls.IconText.VCOIN;
            headerMC.rate_part_1.textColor = loc3;
            headerMC.rate_part_1.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(net.wg.gui.components.controls.IconText.VCOIN);
            headerMC.rate_part_2.icon = net.wg.gui.components.controls.IconText.GOLD;
            headerMC.rate_part_2.textColor = loc4;
            headerMC.rate_part_2.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(net.wg.gui.components.controls.IconText.GOLD);
            this.buyVcoinBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.buyVcoinBtnHandler, false, 0, true);
            this.warningMc.buyVcoinBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.buyVcoinBtnHandler, false, 0, true);
            headerMC.rateLabelFunction = rateLabelFunction;
            return;
        }

        protected override function draw():void
        {
            var loc1:*=NaN;
            super.draw();
            if (!isNaN(this.windowOriginalHeight) && isInvalid(TOTAL_PRIMARY_CURRENCY_INVALID)) 
            {
                if (this.isSubmitOperationAllowed()) 
                {
                    this.warningMc.visible = false;
                    loc1 = this.windowOriginalHeight;
                    onHandPrimaryCurrencyText.textColor = App.colorSchemeMgr.getRGB(net.wg.data.constants.ColorSchemeNames.TEXT_COLOR_VCOIN);
                }
                else 
                {
                    this.warningMc.visible = true;
                    loc1 = this.warningMc.bg.height + this.windowOriginalHeight - this.warningMc.contentPadding;
                    onHandPrimaryCurrencyText.textColor = App.colorSchemeMgr.getRGB(net.wg.data.constants.ColorSchemeNames.TEXT_COLOR_ERROR);
                }
                if (window.height != loc1) 
                {
                    tweenObj.height = loc1;
                    this.animationManager.registerAndLaunch(tweenDuration, window, tweenObj, this.tweenSet);
                }
            }
            return;
        }

        protected override function applyWaitingChanges():void
        {
            var loc1:*=null;
            super.applyWaitingChanges();
            var loc2:*=numChildren;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc1 = this.getChildAt(loc3);
                if (loc1 != waiting) 
                    loc1.visible = !showWaiting;
                ++loc3;
            }
            return;
        }

        protected override function isSubmitOperationAllowed():Boolean
        {
            var loc1:*=-1;
            if (this.exchangeData) 
                loc1 = this.exchangeData.minTransactVal;
            return totalPrimaryCurrency >= loc1;
        }

        protected override function applyResultUpdating():void
        {
            var loc1:*=0;
            var loc2:*=0;
            super.applyResultUpdating();
            if (this.exchangeData) 
            {
                loc1 = Math.min(this.exchangeData.maxTransactVal, totalPrimaryCurrency);
                loc2 = Math.min(this.exchangeData.minTransactVal, totalPrimaryCurrency);
                nsPrimaryCurrency.minimum = loc2;
                nsPrimaryCurrency.maximum = loc1;
                nsSecondaryCurrency.minimum = loc2 * actualRate;
                nsSecondaryCurrency.maximum = loc1 * actualRate;
                this.warningMc.minTransactValue = this.exchangeData.minTransactVal;
                invalidate(TOTAL_PRIMARY_CURRENCY_INVALID);
            }
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            if (this.animationManager) 
            {
                this.animationManager.dispose();
                this.animationManager = null;
            }
            this.buyVcoinBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.buyVcoinBtnHandler);
            this.warningMc.buyVcoinBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.buyVcoinBtnHandler);
            return;
        }

        protected override function submitBtnClickHandler(arg1:flash.events.Event):void
        {
            if (!showWaiting) 
                super.submitBtnClickHandler(arg1);
            return;
        }

        protected override function cancelBtnClickHandler(arg1:flash.events.Event):void
        {
            if (!showWaiting) 
                super.cancelBtnClickHandler(arg1);
            return;
        }

        internal function onTweenComplete(arg1:scaleform.clik.motion.Tween):void
        {
            this.animationManager.unregister(arg1);
            return;
        }

        internal function buyVcoinBtnHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            if (!showWaiting) 
                this.buyVcoinS();
            return;
        }

        internal static function rateLabelFunction(arg1:Number):String
        {
            return App.utils.locale.float(arg1);
        }

        
        {
            tweenObj = {"height":0};
        }

        internal static const tweenDuration:uint=350;

        public var warningMc:net.wg.gui.lobby.window.ExchangeVcoinWarningMC;

        public var mainBackgroundMc:flash.display.MovieClip;

        public var buyVcoinBtn:net.wg.gui.components.controls.SoundButtonEx;

        public var buyVcoin:Function=null;

        internal var animationManager:net.wg.gui.utils.ExcludeTweenManager;

        internal var windowOriginalHeight:Number=NaN;

        internal var tweenSet:Object;

        internal var exchangeData:net.wg.gui.lobby.window.VcoinExchangeDataVO;

        internal static var tweenObj:Object;
    }
}
