package net.wg.gui.lobby.headerTutorial
{
    import scaleform.clik.core.UIComponent;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.controls.SoundButton;
    import flash.text.TextField;
    import scaleform.clik.constants.InvalidationType;
    
    public class StepPanel extends UIComponent
    {
        
        public function StepPanel()
        {
            super();
            this._steps = Vector.<SoundButton>([this.step1,this.step2,this.step3,this.step4,this.step5,this.step6]);
        }
        
        private static function onBtnClick(param1:ButtonEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private static function hideTooltip(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private static function onBackRollover(param1:MouseEvent) : void
        {
            App.toolTipMgr.showComplex(TOOLTIPS.HEADERTUTORIAL_BACK);
        }
        
        private static function onNextRollover(param1:MouseEvent) : void
        {
            App.toolTipMgr.showComplex(TOOLTIPS.HEADERTUTORIAL_NEXT);
        }
        
        public var backBtn:SoundButtonEx;
        
        public var nextBtn:SoundButtonEx;
        
        public var step1:SoundButton;
        
        public var step2:SoundButton;
        
        public var step3:SoundButton;
        
        public var step4:SoundButton;
        
        public var step5:SoundButton;
        
        public var step6:SoundButton;
        
        public var helpTF:TextField;
        
        private var _state:String = "";
        
        private var _steps:Vector.<SoundButton> = null;
        
        override protected function configUI() : void
        {
            var _loc1_:SoundButton = null;
            super.configUI();
            this.backBtn.label = DIALOGS.HEADERTUTORIALWINDOW_BACK;
            this.helpTF.text = DIALOGS.HEADERTUTORIALWINDOW_HELPTEXT;
            this.backBtn.addEventListener(ButtonEvent.CLICK,onBtnClick);
            this.backBtn.addEventListener(MouseEvent.ROLL_OVER,onBackRollover);
            this.backBtn.addEventListener(MouseEvent.ROLL_OUT,hideTooltip);
            this.nextBtn.addEventListener(ButtonEvent.CLICK,onBtnClick);
            this.nextBtn.addEventListener(MouseEvent.ROLL_OVER,onNextRollover);
            this.nextBtn.addEventListener(MouseEvent.ROLL_OUT,hideTooltip);
            for each(_loc1_ in this._steps)
            {
                _loc1_.addEventListener(ButtonEvent.CLICK,this.handleStepClick);
            }
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:SoundButton = null;
            this.backBtn.removeEventListener(ButtonEvent.CLICK,onBtnClick);
            this.backBtn.removeEventListener(MouseEvent.ROLL_OVER,onBackRollover);
            this.backBtn.removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
            this.nextBtn.removeEventListener(ButtonEvent.CLICK,onBtnClick);
            this.nextBtn.removeEventListener(MouseEvent.ROLL_OVER,onNextRollover);
            this.nextBtn.removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
            for each(_loc1_ in this._steps)
            {
                _loc1_.removeEventListener(ButtonEvent.CLICK,this.handleStepClick);
            }
            this.backBtn.dispose();
            this.backBtn = null;
            this.nextBtn.dispose();
            this.nextBtn = null;
            if(this._steps)
            {
                this._steps.splice(0,this._steps.length);
                this._steps = null;
            }
            this.step1 = null;
            this.step2 = null;
            this.step3 = null;
            this.step4 = null;
            this.step5 = null;
            this.step6 = null;
            this.helpTF = null;
        }
        
        public function setState(param1:String) : void
        {
            this._state = param1;
            invalidateState();
        }
        
        override protected function draw() : void
        {
            if((isInvalid(InvalidationType.STATE)) && (this._state))
            {
                this.highlightStep(this._state);
                this.showControls(!(this._state == HeaderTutorialStates.WELCOME));
                if(this._state != HeaderTutorialStates.STEP6)
                {
                    this.nextBtn.label = DIALOGS.HEADERTUTORIALWINDOW_NEXT;
                }
                else
                {
                    this.nextBtn.label = DIALOGS.HEADERTUTORIALWINDOW_FINISH;
                }
                this.backBtn.enabled = !(this._state == HeaderTutorialStates.STEP1);
            }
        }
        
        private function showControls(param1:Boolean) : void
        {
            var _loc2_:SoundButton = null;
            for each(_loc2_ in this._steps)
            {
                _loc2_.visible = param1;
            }
            this.helpTF.visible = this.backBtn.visible = this.nextBtn.visible = param1;
        }
        
        private function highlightStep(param1:String) : void
        {
            var _loc2_:SoundButton = null;
            for each(_loc2_ in this._steps)
            {
                _loc2_.selected = _loc2_.name == param1;
            }
        }
        
        private function handleStepClick(param1:ButtonEvent) : void
        {
            App.toolTipMgr.hide();
            var _loc2_:int = this._steps.indexOf(param1.target) + 1;
            dispatchEvent(new HeaderTutorialEvent(HeaderTutorialEvent.STEP_CHANGED,_loc2_));
        }
    }
}
