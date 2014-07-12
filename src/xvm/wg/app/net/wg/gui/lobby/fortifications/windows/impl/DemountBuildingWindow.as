package net.wg.gui.lobby.fortifications.windows.impl
{
    import net.wg.infrastructure.base.meta.impl.DemountBuildingWindowMeta;
    import net.wg.infrastructure.base.meta.IDemountBuildingWindowMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.common.InputChecker;
    import net.wg.data.Aliases;
    import net.wg.infrastructure.events.FocusRequestEvent;
    import scaleform.clik.events.ButtonEvent;
    import flash.display.InteractiveObject;
    import net.wg.gui.lobby.fortifications.data.demountBuilding.DemountBuildingVO;
    import flash.events.Event;
    
    public class DemountBuildingWindow extends DemountBuildingWindowMeta implements IDemountBuildingWindowMeta
    {
        
        public function DemountBuildingWindow() {
            super();
            isModal = true;
            isCentered = true;
            canDrag = false;
            this.titleText.mouseEnabled = this.bodyText.mouseEnabled = false;
        }
        
        public var titleText:TextField;
        
        public var bodyText:TextField;
        
        public var applyButton:SoundButtonEx;
        
        public var cancelButton:SoundButtonEx;
        
        public var inputChecker:InputChecker;
        
        override protected function configUI() : void {
            super.configUI();
        }
        
        override protected function onPopulate() : void {
            super.onPopulate();
            window.useBottomBtns = true;
            registerComponent(this.inputChecker,Aliases.INPUT_CHECKER_COMPONENT);
            this.inputChecker.addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onRequestFocusHandler);
            this.applyButton.addEventListener(ButtonEvent.CLICK,this.onClickApplyBtnHandler);
            this.applyButton.enabled = false;
            this.cancelButton.addEventListener(ButtonEvent.CLICK,this.onClickCancelBtnHandler);
        }
        
        override protected function onDispose() : void {
            this.inputChecker.removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onRequestFocusHandler);
            this.cancelButton.removeEventListener(ButtonEvent.CLICK,this.onClickCancelBtnHandler);
            this.cancelButton.dispose();
            this.cancelButton = null;
            this.applyButton.removeEventListener(ButtonEvent.CLICK,this.onClickApplyBtnHandler);
            this.applyButton.dispose();
            this.applyButton = null;
            App.utils.scheduler.cancelTask(this.updateFocus);
            super.onDispose();
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void {
            super.onInitModalFocus(param1);
            setFocus(this.inputChecker.textInput);
        }
        
        override protected function setData(param1:DemountBuildingVO) : void {
            window.title = param1.windowTitle;
            this.titleText.htmlText = param1.headerQuestion;
            this.bodyText.htmlText = param1.bodyText;
            this.applyButton.label = param1.applyButtonLbl;
            this.cancelButton.label = param1.cancelButtonLbl;
        }
        
        private function updateFocus() : void {
            setFocus(this.applyButton);
        }
        
        private function onClickApplyBtnHandler(param1:ButtonEvent) : void {
            applyDemountS();
        }
        
        private function onClickCancelBtnHandler(param1:ButtonEvent) : void {
            onWindowCloseS();
        }
        
        private function onRequestFocusHandler(param1:Event) : void {
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
