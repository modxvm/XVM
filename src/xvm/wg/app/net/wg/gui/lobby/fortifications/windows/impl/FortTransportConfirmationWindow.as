package net.wg.gui.lobby.fortifications.windows.impl
{
    import net.wg.infrastructure.base.meta.impl.FortTransportConfirmationWindowMeta;
    import net.wg.infrastructure.base.meta.IFortTransportConfirmationWindowMeta;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.controls.NumericStepper;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.lobby.fortifications.cmp.build.IBuildingIndicator;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.fortifications.data.base.BuildingBaseVO;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.fortifications.data.FortInvalidationType;
    import net.wg.data.constants.generated.EVENT_LOG_CONSTANTS;
    import net.wg.gui.lobby.fortifications.data.TransportingVO;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.events.IndexEvent;
    import net.wg.gui.lobby.fortifications.utils.impl.FortCommonUtils;
    import flash.text.TextFormatAlign;
    import flash.display.InteractiveObject;
    import net.wg.utils.ITweenAnimator;
    import net.wg.gui.lobby.fortifications.utils.impl.TweenAnimator;
    
    public class FortTransportConfirmationWindow extends FortTransportConfirmationWindowMeta implements IFortTransportConfirmationWindowMeta
    {
        
        public function FortTransportConfirmationWindow()
        {
            super();
            isModal = true;
            canDrag = false;
            isCentered = true;
            UIID = 24;
            this.transportButton.UIID = 25;
            this.cancelButton.UIID = 26;
        }
        
        public var transportButton:SoundButtonEx = null;
        
        public var cancelButton:SoundButtonEx = null;
        
        public var resourceNumericStepper:NumericStepper = null;
        
        public var transportingText:TextField = null;
        
        public var maxTransportingSizeLabel:TextField = null;
        
        public var footerFadingText:TextField = null;
        
        public var sourceTextField:TextField = null;
        
        public var targetTextField:TextField = null;
        
        public var nutLoader:UILoaderAlt = null;
        
        public var sourceIndicator:IBuildingIndicator = null;
        
        public var targetIndicator:IBuildingIndicator = null;
        
        public var transportingLoader:UILoaderAlt = null;
        
        public var arrowLoader:UILoaderAlt = null;
        
        public var separator:MovieClip = null;
        
        private var _initialTargetBaseVO:BuildingBaseVO = null;
        
        private var _initialSourceBaseVO:BuildingBaseVO = null;
        
        public function as_setMaxTransportingSize(param1:String) : void
        {
            this.maxTransportingSizeLabel.htmlText = param1;
        }
        
        public function as_setFooterText(param1:String) : void
        {
            this.footerFadingText.htmlText = param1;
        }
        
        public function as_enableForFirstTransporting(param1:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this._initialSourceBaseVO,"_initialSourceBaseVO" + Errors.CANT_NULL);
            App.utils.asserter.assertNotNull(this._initialTargetBaseVO,"_initialTargetBaseVO" + Errors.CANT_NULL);
            this.maxTransportingSizeLabel.visible = !param1;
            if(param1)
            {
                this.resourceNumericStepper.value = this.resourceNumericStepper.minimum = this.resourceNumericStepper.maximum;
                this.updateSourceData(this.resourceNumericStepper.value);
                this.updateTargetData(this.resourceNumericStepper.value);
            }
            this.resourceNumericStepper.enabled = !param1;
            if(hasFocus)
            {
                this.updateFocus();
            }
            invalidate(FortInvalidationType.INVALID_ENABLING);
        }
        
        private function updateFocus() : void
        {
            if(!this.resourceNumericStepper.enabled)
            {
                setFocus(this.transportButton);
            }
            else
            {
                setFocus(this.cancelButton);
            }
        }
        
        private function updateTargetData(param1:Number) : void
        {
            var _loc4_:* = NaN;
            var _loc2_:BuildingBaseVO = new BuildingBaseVO(this._initialTargetBaseVO.toHash());
            var _loc3_:Number = Math.min(_loc2_.maxHpValue - _loc2_.hpVal,param1);
            _loc2_.hpVal = _loc2_.hpVal + _loc3_;
            var param1:Number = param1 - _loc3_;
            if(param1 > 0)
            {
                _loc4_ = Math.min(_loc2_.maxDefResValue - _loc2_.defResVal,param1);
                _loc2_.defResVal = _loc2_.defResVal + _loc4_;
            }
            this.targetIndicator.applyVOData(_loc2_);
            _loc2_.dispose();
        }
        
        private function updateSourceData(param1:Number) : void
        {
            var _loc2_:BuildingBaseVO = new BuildingBaseVO(this._initialSourceBaseVO.toHash());
            _loc2_.defResVal = _loc2_.defResVal - param1;
            this.sourceIndicator.applyVOData(_loc2_);
            _loc2_.dispose();
        }
        
        override protected function onClosingApproved() : void
        {
            App.eventLogManager.logUIElement(this,EVENT_LOG_CONSTANTS.EVENT_TYPE_ON_WINDOW_CLOSE,0);
        }
        
        override protected function setData(param1:TransportingVO) : void
        {
            this.resourceNumericStepper.maximum = param1.maxTransportingSize;
            this.sourceIndicator.applyVOData(param1.sourceBaseVO);
            this._initialSourceBaseVO = param1.sourceBaseVO;
            this._initialTargetBaseVO = param1.targetBaseVO;
            this.updateSourceData(0);
            this.updateTargetData(0);
            this.sourceTextField.text = FORTIFICATIONS.buildings_buildingname(param1.sourceBaseVO.uid);
            this.targetTextField.text = FORTIFICATIONS.buildings_buildingname(param1.targetBaseVO.uid);
            this.resourceNumericStepper.stepSize = param1.defResTep;
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            window.title = FORTIFICATIONS.FORTTRANSPORTCONFIRMATIONWINDOW_TITLE;
            window.useBottomBtns = true;
            App.eventLogManager.logUIElement(this,EVENT_LOG_CONSTANTS.EVENT_TYPE_ON_WINDOW_OPEN,0);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.footerFadingText.alpha = 0;
            this.separator.mouseEnabled = false;
            this.transportButton.label = FORTIFICATIONS.FORTTRANSPORTCONFIRMATIONWINDOW_TRANSPORTBUTTON;
            this.cancelButton.label = FORTIFICATIONS.FORTTRANSPORTCONFIRMATIONWINDOW_CANCELBUTTON;
            this.transportingText.htmlText = FORTIFICATIONS.FORTTRANSPORTCONFIRMATIONWINDOW_TRANSPORTINGTEXT;
            this.transportButton.addEventListener(ButtonEvent.CLICK,this.onTransportingButtonClickHandler);
            this.cancelButton.addEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
            this.resourceNumericStepper.addEventListener(IndexEvent.INDEX_CHANGE,this.onResourceNumericStepperIndexChangeHandler);
            FortCommonUtils.instance.changeTextAlign(this.resourceNumericStepper.textField,TextFormatAlign.RIGHT);
            this.getTweenAnimator().addFadeInAnim(this.sourceIndicator.labels,null);
            this.getTweenAnimator().addFadeInAnim(this.targetIndicator.labels,null);
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(this.cancelButton);
            this.updateFocus();
        }
        
        private function getTweenAnimator() : ITweenAnimator
        {
            return TweenAnimator.instance;
        }
        
        override protected function onDispose() : void
        {
            this.getTweenAnimator().removeAnims(this.footerFadingText);
            this.getTweenAnimator().removeAnims(this.sourceIndicator.labels);
            this.getTweenAnimator().removeAnims(this.targetIndicator.labels);
            this.transportButton.removeEventListener(ButtonEvent.CLICK,this.onTransportingButtonClickHandler);
            this.cancelButton.removeEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
            this.resourceNumericStepper.removeEventListener(IndexEvent.INDEX_CHANGE,this.onResourceNumericStepperIndexChangeHandler);
            this._initialSourceBaseVO.dispose();
            this._initialSourceBaseVO = null;
            this._initialTargetBaseVO.dispose();
            this._initialTargetBaseVO = null;
            this.transportButton.dispose();
            this.transportButton = null;
            this.cancelButton.dispose();
            this.cancelButton = null;
            this.resourceNumericStepper.dispose();
            this.resourceNumericStepper = null;
            this.transportingText = null;
            this.maxTransportingSizeLabel = null;
            this.footerFadingText = null;
            this.nutLoader.dispose();
            this.nutLoader = null;
            this.transportingLoader.dispose();
            this.transportingLoader = null;
            this.arrowLoader.dispose();
            this.arrowLoader = null;
            this.sourceIndicator.dispose();
            this.sourceIndicator = null;
            this.targetIndicator.dispose();
            this.targetIndicator = null;
            this.sourceTextField = null;
            this.targetTextField = null;
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            var _loc1_:* = false;
            super.draw();
            if(isInvalid(FortInvalidationType.INVALID_ENABLING))
            {
                _loc1_ = this.resourceNumericStepper.value > 0;
                if((_loc1_) && this.footerFadingText.alpha == 0)
                {
                    this.getTweenAnimator().addFadeInAnim(this.footerFadingText,null);
                }
                else if(!_loc1_ && this.footerFadingText.alpha > 0)
                {
                    this.getTweenAnimator().addFadeOutAnim(this.footerFadingText,null);
                }
                
                this.transportButton.enabled = _loc1_;
            }
        }
        
        private function onResourceNumericStepperIndexChangeHandler(param1:IndexEvent) : void
        {
            if(this.resourceNumericStepper.value == this.resourceNumericStepper.maximum)
            {
                onTransportingLimitS();
            }
            this.updateSourceData(this.resourceNumericStepper.value);
            this.updateTargetData(this.resourceNumericStepper.value);
            invalidate(FortInvalidationType.INVALID_ENABLING);
        }
        
        private function onTransportingButtonClickHandler(param1:ButtonEvent) : void
        {
            App.eventLogManager.logUIEvent(param1,0);
            onTransportingS(this.resourceNumericStepper.value);
        }
        
        private function onCancelButtonClickHandler(param1:ButtonEvent) : void
        {
            App.eventLogManager.logUIEvent(param1,0);
            onCancelS();
        }
    }
}
