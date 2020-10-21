package net.wg.gui.lobby.eventMessageWindow.views
{
    import net.wg.gui.components.controls.universalBtn.UniversalBtn;
    import flash.display.MovieClip;
    import flash.display.InteractiveObject;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.data.constants.UniversalBtnStylesConst;
    import flash.events.Event;

    public class InfoMessageView extends MessageViewBase
    {

        public var btnExecute:UniversalBtn = null;

        public var separator:MovieClip = null;

        public function InfoMessageView()
        {
            super();
        }

        override public function getFocusTarget() : InteractiveObject
        {
            return this.btnExecute;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.btnExecute.addEventListener(ButtonEvent.CLICK,this.onBtnExecuteClickHandler);
            App.utils.universalBtnStyles.setStyle(this.btnExecute,UniversalBtnStylesConst.STYLE_HEAVY_GREEN);
            animContainerTitle.gotoAndPlay(IN_STATE);
        }

        override protected function onDispose() : void
        {
            this.btnExecute.removeEventListener(ButtonEvent.CLICK,this.onBtnExecuteClickHandler);
            this.btnExecute.dispose();
            this.btnExecute = null;
            this.separator = null;
            super.onDispose();
        }

        override protected function updateContent() : void
        {
            super.updateContent();
            this.btnExecute.label = _messageData.labelExecute;
            this.btnExecute.enabled = true;
        }

        override protected function playOutroAnimationStarted() : void
        {
            super.playOutroAnimationStarted();
            this.btnExecute.mouseEnabled = this.btnExecute.mouseChildren = false;
        }

        private function onBtnExecuteClickHandler(param1:Event) : void
        {
            handleConfirm();
        }
    }
}
