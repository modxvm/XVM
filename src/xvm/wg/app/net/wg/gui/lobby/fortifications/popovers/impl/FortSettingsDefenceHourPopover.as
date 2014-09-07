package net.wg.gui.lobby.fortifications.popovers.impl
{
    import net.wg.infrastructure.base.meta.impl.FortSettingsDefenceHourPopoverMeta;
    import net.wg.infrastructure.base.meta.IFortSettingsDefenceHourPopoverMeta;
    import flash.events.MouseEvent;
    import scaleform.clik.events.ButtonEvent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.TimeNumericStepper;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.IWrapper;
    import net.wg.gui.components.popOvers.PopOver;
    import flash.events.Event;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.components.popOvers.PopOverConst;
    import flash.display.InteractiveObject;
    import net.wg.gui.lobby.fortifications.data.settings.DefenceHourPopoverVO;
    import net.wg.gui.lobby.fortifications.utils.impl.FortCommonUtils;
    import net.wg.data.constants.Values;
    
    public class FortSettingsDefenceHourPopover extends FortSettingsDefenceHourPopoverMeta implements IFortSettingsDefenceHourPopoverMeta
    {
        
        public function FortSettingsDefenceHourPopover()
        {
            super();
        }
        
        private static var DEFAULT_CONTENT_WIDTH:int = 300;
        
        private static var DEFAULT_PADDING:int = 10;
        
        private static function onApplyBtnRollOut(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private static function onCancelBtnClick(param1:ButtonEvent) : void
        {
            App.popoverMgr.hide();
        }
        
        public var descriptionTF:TextField = null;
        
        public var defenceHourTF:TextField = null;
        
        public var tillHourTF:TextField = null;
        
        public var dashTF:TextField = null;
        
        public var timeStepper:TimeNumericStepper = null;
        
        public var applyBtn:SoundButtonEx = null;
        
        public var cancelBtn:SoundButtonEx = null;
        
        public var separatorTop:MovieClip = null;
        
        public var separatorBottom:MovieClip = null;
        
        private var isAmericanStyle:Boolean = false;
        
        private var currentDefenceHour:int = -1;
        
        override public function set wrapper(param1:IWrapper) : void
        {
            super.wrapper = param1;
            PopOver(param1).isCloseBtnVisible = true;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.applyBtn.mouseEnabledOnDisabled = true;
            this.applyBtn.addEventListener(ButtonEvent.CLICK,this.onApplyBtnClick);
            this.applyBtn.addEventListener(MouseEvent.MOUSE_OVER,this.onApplyBtnRollOver);
            this.applyBtn.addEventListener(MouseEvent.MOUSE_OUT,onApplyBtnRollOut);
            this.cancelBtn.addEventListener(ButtonEvent.CLICK,onCancelBtnClick);
            this.timeStepper.addEventListener(Event.CHANGE,this.timeStepperChangeHandler);
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
        }
        
        override protected function onDispose() : void
        {
            this.applyBtn.removeEventListener(ButtonEvent.CLICK,this.onApplyBtnClick);
            this.applyBtn.removeEventListener(MouseEvent.MOUSE_OVER,this.onApplyBtnRollOver);
            this.applyBtn.removeEventListener(MouseEvent.MOUSE_OUT,onApplyBtnRollOut);
            this.cancelBtn.removeEventListener(ButtonEvent.CLICK,onCancelBtnClick);
            this.timeStepper.removeEventListener(Event.CHANGE,this.timeStepperChangeHandler);
            this.descriptionTF = null;
            this.defenceHourTF = null;
            this.dashTF = null;
            this.tillHourTF = null;
            this.applyBtn.dispose();
            this.applyBtn = null;
            this.cancelBtn.dispose();
            this.cancelBtn = null;
            this.separatorTop = null;
            this.separatorBottom = null;
            this.timeStepper.dispose();
            this.timeStepper = null;
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            if(isInvalid(InvalidationType.SIZE))
            {
                setSize(DEFAULT_CONTENT_WIDTH > this.width?DEFAULT_CONTENT_WIDTH:this.width,this.applyBtn.y + this.applyBtn.height + DEFAULT_PADDING);
                this.separatorTop.width = this.width;
                this.separatorBottom.width = this.width;
            }
            super.draw();
        }
        
        override protected function initLayout() : void
        {
            popoverLayout.preferredLayout = PopOverConst.ARROW_LEFT;
            super.initLayout();
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(this.timeStepper);
        }
        
        override protected function setData(param1:DefenceHourPopoverVO) : void
        {
            this.isAmericanStyle = param1.isAmericanStyle;
            this.timeStepper.isTwelveHoursFormat = this.isAmericanStyle;
            this.timeStepper.value = this.currentDefenceHour = param1.hour;
            this.timeStepper.skipValues = param1.skipValues;
            this.tillHourTF.visible = this.dashTF.visible = !this.timeStepper.currentValueIsDefault;
            this.tillHourTF.text = FortCommonUtils.instance.getNextHourText(param1.hour);
            this.applyBtn.enabled = false;
        }
        
        override protected function setTexts(param1:DefenceHourPopoverVO) : void
        {
            this.descriptionTF.htmlText = param1.descriptionText;
            this.defenceHourTF.htmlText = param1.defenceHourText;
            this.applyBtn.label = param1.applyBtnLabel;
            this.cancelBtn.label = param1.cancelBtnLabel;
        }
        
        private function onApplyBtnClick(param1:ButtonEvent) : void
        {
            onApplyS(this.timeStepper.value);
            App.popoverMgr.hide();
        }
        
        private function onApplyBtnRollOver(param1:MouseEvent) : void
        {
            var _loc2_:String = Values.EMPTY_STR;
            if(this.applyBtn.enabled)
            {
                _loc2_ = TOOLTIPS.FORTIFICATION_FORTSETTINGSDEFENCEHOURPOPOVER_APPLYBTN_ENABLED;
            }
            else
            {
                _loc2_ = TOOLTIPS.FORTIFICATION_FORTSETTINGSDEFENCEHOURPOPOVER_APPLYBTN_DISABLED;
            }
            App.toolTipMgr.show(_loc2_);
        }
        
        private function timeStepperChangeHandler(param1:Event) : void
        {
            this.tillHourTF.visible = this.dashTF.visible = !this.timeStepper.currentValueIsDefault;
            this.tillHourTF.text = FortCommonUtils.instance.getNextHourText(this.timeStepper.value);
            this.applyBtn.enabled = !(this.timeStepper.value == this.currentDefenceHour);
        }
    }
}
