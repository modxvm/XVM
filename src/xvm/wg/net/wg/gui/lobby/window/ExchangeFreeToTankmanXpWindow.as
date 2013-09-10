package net.wg.gui.lobby.window 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class ExchangeFreeToTankmanXpWindow extends net.wg.infrastructure.base.meta.impl.ExchangeFreeToTankmanXpWindowMeta implements net.wg.infrastructure.base.meta.IExchangeFreeToTankmanXpWindowMeta
    {
        public function ExchangeFreeToTankmanXpWindow()
        {
            super();
            isModal = false;
            canResize = false;
            canMinimize = false;
            isCentered = true;
            showWindowBg = false;
            return;
        }

        public function as_setInitData(arg1:Object):void
        {
            this.initData = new net.wg.gui.lobby.window.ExchangeFreeToTankmanInitVO(arg1);
            invalidate(INIT_DATA_INVALID);
            return;
        }

        public function as_setCalcValueResponse(arg1:Number):void
        {
            this.itToPay.text = App.utils.locale.integer(arg1);
            this.submitBtn.enabled = arg1 > 0;
            this.initData.afterSkill.level = this.selectedValue;
            this.skillAfter.data = this.initData.afterSkill;
            return;
        }

        public override function set window(arg1:net.wg.infrastructure.interfaces.IWindow):void
        {
            super.window = arg1;
            if (arg1) 
            {
                window.title = MENU.TEACHINGSKILL_TITLE;
                addEventListener(flash.events.Event.ENTER_FRAME, this.calcHeightInNextFrame, false, 0, true);
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
            super.configUI();
            this.submitBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onClickSubmitButton, false, 0, true);
            this.cancelBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onClickCancelButton, false, 0, true);
            this.nsLevel.addEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.nsFirstCurrencyChangeHandler, false, 0, true);
            try 
                this.warningMc.textField.text = App.utils.locale.makeString(MENU.TEACHINGSKILL_FREEXPISTIGHT);
            catch (e:Error)
            {
            };
            this.warningMc.visible = false;
            this.blockMc.visible = false;
            var loc1:*=this.background.parent.getChildIndex(this.background) + 1;
            var loc2:*=new flash.display.Sprite();
            addChildAt(loc2, loc1);
            loc2.addChild(this.afterTeachingHeader);
            loc2.addChild(this.skillAfter);
            loc2.addChild(this.submitBtn);
            loc2.addChild(this.cancelBtn);
            constraints.addElement(this.background.name, this.background, scaleform.clik.utils.Constraints.ALL);
            constraints.addElement(this.form_bg.name, this.form_bg, scaleform.clik.utils.Constraints.ALL);
            constraints.addElement(MOVINGCONTAINER_NAME, loc2, scaleform.clik.utils.Constraints.BOTTOM);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=false;
            super.draw();
            if (isInvalid(INIT_DATA_INVALID)) 
                if (this.initData) 
                {
                    this.nsLevel.minimum = this.initData.lastSkillLevel;
                    this.nsLevel.maximum = this.initData.nextSkillLevel;
                    this.nsLevel.value = this.nsLevel.maximum;
                    this.nsLevel.enabled = !(this.initData.lastSkillLevel == this.initData.nextSkillLevel);
                    this.blockMc.visible = !this.nsLevel.enabled;
                    this.skillBefore.data = this.initData.beforeSkill;
                    this.skillAfter.data = this.initData.afterSkill;
                    this.selectedValue = this.nsLevel.value;
                    invalidate(SELECTED_VALUE_INVALID);
                    invalidate(WARNING_INVALID);
                }
            if (isInvalid(SELECTED_VALUE_INVALID)) 
                if (this.initData) 
                    calcValueRequestS(this.selectedValue);
            if (isInvalid(WARNING_INVALID) && !isNaN(this.originalWindowHeight)) 
            {
                loc1 = !this.nsLevel.enabled;
                if (loc1 != this.warningMc.visible) 
                {
                    this.warningMc.visible = loc1;
                    if (loc1) 
                        window.height = this.expandedWindowHeight;
                    else 
                        window.height = this.originalWindowHeight;
                }
            }
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.submitBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onClickSubmitButton, false, 0, true);
            this.cancelBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onClickCancelButton, false, 0, true);
            removeEventListener(flash.events.Event.ENTER_FRAME, this.calcHeightInNextFrame);
            return;
        }

        internal function nsFirstCurrencyChangeHandler(arg1:scaleform.clik.events.IndexEvent):void
        {
            this.selectedValue = this.nsLevel.value;
            invalidate(SELECTED_VALUE_INVALID);
            return;
        }

        internal function calcHeightInNextFrame(arg1:flash.events.Event):void
        {
            removeEventListener(flash.events.Event.ENTER_FRAME, this.calcHeightInNextFrame);
            this.originalWindowHeight = window.height;
            this.expandedWindowHeight = this.originalWindowHeight + this.warningMc.height - 30;
            invalidate(WARNING_INVALID);
            return;
        }

        internal function onClickSubmitButton(arg1:scaleform.clik.events.ButtonEvent):void
        {
            applyS();
            return;
        }

        internal function onClickCancelButton(arg1:scaleform.clik.events.ButtonEvent):void
        {
            onWindowCloseS();
            return;
        }

        public static const INIT_DATA_INVALID:String="initDataInv";

        public static const SELECTED_VALUE_INVALID:String="selValInvalid";

        public static const WARNING_INVALID:String="warningInvalid";

        internal static const MOVINGCONTAINER_NAME:String="movingContainer";

        public var nsLevel:net.wg.gui.components.controls.NumericStepper;

        public var form_bg:flash.display.MovieClip;

        public var itToPay:net.wg.gui.components.controls.IconText;

        public var background:flash.display.Sprite;

        public var warningMc:net.wg.gui.lobby.window.ExchangeFreeToTankmanXpWarning;

        public var submitBtn:net.wg.gui.components.controls.SoundButtonEx;

        public var cancelBtn:net.wg.gui.components.controls.SoundButtonEx;

        public var skillAfter:net.wg.gui.components.advanced.SkillsItemRenderer;

        public var skillBefore:net.wg.gui.components.advanced.SkillsItemRenderer;

        public var afterTeachingHeader:flash.text.TextField;

        public var blockMc:flash.display.MovieClip;

        internal var initData:net.wg.gui.lobby.window.ExchangeFreeToTankmanInitVO;

        internal var selectedValue:uint;

        internal var originalWindowHeight:Number=NaN;

        internal var expandedWindowHeight:Number=NaN;
    }
}
