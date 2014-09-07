package net.wg.gui.lobby.fortifications
{
    import net.wg.infrastructure.base.meta.impl.FortDisableDefencePeriodWindowMeta;
    import net.wg.infrastructure.base.meta.IFortDisableDefencePeriodWindowMeta;
    import flash.text.TextField;
    import net.wg.gui.components.common.ArrowSeparator;
    import net.wg.gui.components.common.InputChecker;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.data.Aliases;
    import net.wg.infrastructure.events.FocusRequestEvent;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.fortifications.data.settings.DisableDefencePeriodVO;
    import flash.display.InteractiveObject;
    import flash.events.Event;
    
    public class FortDisableDefencePeriodWindow extends FortDisableDefencePeriodWindowMeta implements IFortDisableDefencePeriodWindowMeta
    {
        
        public function FortDisableDefencePeriodWindow()
        {
            super();
            isModal = true;
            isCentered = true;
            canDrag = false;
        }
        
        public var titleText:TextField = null;
        
        public var bodyText:TextField = null;
        
        public var arrowSeparator:ArrowSeparator = null;
        
        public var inputChecker:InputChecker = null;
        
        public var applyButton:SoundButtonEx = null;
        
        public var cancelButton:SoundButtonEx = null;
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            window.title = FORTIFICATIONS.DISABLEDEFENCEPERIODWINDOW_WINDOWTITLE;
            window.useBottomBtns = true;
            registerComponent(this.inputChecker,Aliases.INPUT_CHECKER_COMPONENT);
            this.inputChecker.addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onRequestFocusHandler);
            this.cancelButton.addEventListener(ButtonEvent.CLICK,this.onClickCancelBtnHandler);
            this.cancelButton.label = FORTIFICATIONS.DISABLEDEFENCEPERIODWINDOW_CANCELBUTTON_LBL;
            this.applyButton.addEventListener(ButtonEvent.CLICK,this.onClickApplyBtnHandler);
            this.applyButton.label = FORTIFICATIONS.DISABLEDEFENCEPERIODWINDOW_APPLYBUTTON_LBL;
            this.applyButton.enabled = false;
        }
        
        override protected function setData(param1:DisableDefencePeriodVO) : void
        {
            this.titleText.htmlText = param1.titleText;
            this.bodyText.htmlText = param1.bodyText;
        }
        
        private function onClickApplyBtnHandler(param1:ButtonEvent) : void
        {
            onClickApplyButtonS();
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(this.inputChecker.textInput);
        }
        
        override protected function onDispose() : void
        {
            this.cancelButton.removeEventListener(ButtonEvent.CLICK,this.onClickCancelBtnHandler);
            this.cancelButton.dispose();
            this.cancelButton = null;
            this.applyButton.removeEventListener(ButtonEvent.CLICK,this.onClickApplyBtnHandler);
            this.applyButton.dispose();
            this.applyButton = null;
            this.arrowSeparator.dispose();
            this.arrowSeparator = null;
            super.onDispose();
        }
        
        private function onClickCancelBtnHandler(param1:ButtonEvent) : void
        {
            onWindowCloseS();
        }
        
        private function updateFocus() : void
        {
            setFocus(this.applyButton);
        }
        
        private function onRequestFocusHandler(param1:Event) : void
        {
            if(this.inputChecker.isInvalidUserText)
            {
                this.applyButton.enabled = true;
                App.utils.scheduler.envokeInNextFrame(this.updateFocus);
            }
            else
            {
                this.applyButton.enabled = false;
                setFocus(this.inputChecker.getComponentForFocus());
            }
        }
    }
}
