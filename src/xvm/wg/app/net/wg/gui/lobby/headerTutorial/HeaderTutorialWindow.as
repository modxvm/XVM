package net.wg.gui.lobby.headerTutorial
{
    import net.wg.infrastructure.base.meta.impl.HeaderTutorialWindowMeta;
    import net.wg.infrastructure.base.meta.IHeaderTutorialWindowMeta;
    import flash.events.MouseEvent;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import scaleform.clik.events.ButtonEvent;
    import flash.display.InteractiveObject;
    import scaleform.clik.constants.InvalidationType;
    
    public class HeaderTutorialWindow extends HeaderTutorialWindowMeta implements IHeaderTutorialWindowMeta
    {
        
        public function HeaderTutorialWindow()
        {
            super();
            isCentered = true;
            isModal = true;
            canDrag = false;
        }
        
        private static var WELCOME_X_PADDING:int = 22;
        
        private static var TUTORIAL_X_PADDING:int = 26;
        
        private static var WELCOME_TITLE_Y:int = 168;
        
        private static var TUTORIAL_TITLE_Y:int = 28;
        
        private static var WELCOME_TEXT_Y:int = 202;
        
        private static var TUTORIAL_TEXT_Y:int = 60;
        
        private static function onLeaveRollover(param1:MouseEvent) : void
        {
            App.toolTipMgr.showComplex(TOOLTIPS.HEADERTUTORIAL_BREAKTUTORIAL);
        }
        
        private static function onLeaveRollout(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var startBtn:SoundButtonEx;
        
        public var leaveBtn:SoundButtonEx;
        
        public var titleTF:TextField;
        
        public var mainTextTF:TextField;
        
        public var stateScreen:MovieClip;
        
        public var stepPanel:StepPanel;
        
        private var _data:HeaderTutorialVO = null;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.addListeners();
            this.startBtn.label = DIALOGS.HEADERTUTORIALWINDOW_SUBMIT;
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            window.useBottomBtns = true;
        }
        
        private function addListeners() : void
        {
            this.startBtn.addEventListener(ButtonEvent.CLICK,this.onStartClick);
            this.leaveBtn.addEventListener(ButtonEvent.CLICK,this.onLeaveClick);
            this.leaveBtn.addEventListener(MouseEvent.ROLL_OVER,onLeaveRollover);
            this.leaveBtn.addEventListener(MouseEvent.ROLL_OUT,onLeaveRollout);
            this.stepPanel.nextBtn.addEventListener(ButtonEvent.CLICK,this.onNextStepClick);
            this.stepPanel.backBtn.addEventListener(ButtonEvent.CLICK,this.onPrevStepClick);
            this.stepPanel.addEventListener(HeaderTutorialEvent.STEP_CHANGED,this.onStepChange);
        }
        
        override protected function onDispose() : void
        {
            this.removeListeners();
            this.startBtn.dispose();
            this.startBtn = null;
            this.leaveBtn.dispose();
            this.leaveBtn = null;
            this.stepPanel.dispose();
            this.stepPanel = null;
            if(this._data)
            {
                this._data.dispose();
                this._data = null;
            }
            this.titleTF = null;
            this.mainTextTF = null;
            this.stateScreen = null;
        }
        
        private function removeListeners() : void
        {
            this.startBtn.removeEventListener(ButtonEvent.CLICK,this.onStartClick);
            this.leaveBtn.removeEventListener(ButtonEvent.CLICK,this.onLeaveClick);
            this.leaveBtn.removeEventListener(MouseEvent.ROLL_OVER,onLeaveRollover);
            this.leaveBtn.removeEventListener(MouseEvent.ROLL_OUT,onLeaveRollout);
            this.stepPanel.nextBtn.removeEventListener(ButtonEvent.CLICK,this.onNextStepClick);
            this.stepPanel.backBtn.removeEventListener(ButtonEvent.CLICK,this.onPrevStepClick);
            this.stepPanel.removeEventListener(HeaderTutorialEvent.STEP_CHANGED,this.onStepChange);
        }
        
        override protected function setData(param1:HeaderTutorialVO) : void
        {
            this._data = param1;
            invalidateData();
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            if(this.startBtn.visible)
            {
                setFocus(this.startBtn);
            }
            else
            {
                setFocus(this.stepPanel.nextBtn);
            }
        }
        
        override protected function draw() : void
        {
            if((isInvalid(InvalidationType.DATA)) && (this._data))
            {
                window.title = this._data.windowTitle;
                this.titleTF.htmlText = this._data.title;
                this.mainTextTF.htmlText = this._data.text;
                this.setState(this._data.state);
            }
            super.draw();
        }
        
        private function setState(param1:String) : void
        {
            if(param1 == HeaderTutorialStates.WELCOME)
            {
                this.mainTextTF.x = this.titleTF.x = WELCOME_X_PADDING;
                this.titleTF.y = WELCOME_TITLE_Y;
                this.mainTextTF.y = WELCOME_TEXT_Y;
                this.startBtn.visible = true;
                this.leaveBtn.label = DIALOGS.HEADERTUTORIALWINDOW_CANCEL;
            }
            else
            {
                this.mainTextTF.x = this.titleTF.x = TUTORIAL_X_PADDING;
                this.titleTF.y = TUTORIAL_TITLE_Y;
                this.mainTextTF.y = TUTORIAL_TEXT_Y;
                this.startBtn.visible = false;
                this.leaveBtn.label = DIALOGS.HEADERTUTORIALWINDOW_PAUSETUTORIAL;
            }
            this.stateScreen.gotoAndStop(param1);
            this.stepPanel.setState(param1);
            this.mainTextTF.width = Math.round(this.stateScreen.width - this.mainTextTF.x * 2);
            this.mainTextTF.height = Math.round(this.stateScreen.height - this.mainTextTF.y);
        }
        
        private function onStartClick(param1:ButtonEvent) : void
        {
            goNextStepS();
        }
        
        private function onLeaveClick(param1:ButtonEvent) : void
        {
            App.toolTipMgr.hide();
            requestToLeaveS();
        }
        
        private function onNextStepClick(param1:ButtonEvent) : void
        {
            goNextStepS();
        }
        
        private function onPrevStepClick(param1:ButtonEvent) : void
        {
            goPrevStepS();
        }
        
        private function onStepChange(param1:HeaderTutorialEvent) : void
        {
            setStepS(param1.step);
        }
    }
}
