package net.wg.gui.lobby.eventMessageWindow.views
{
    import net.wg.gui.components.controls.universalBtn.UniversalBtn;
    import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.eventMessageWindow.controls.MessageStorageAmountContainer;
    import flash.display.InteractiveObject;
    import net.wg.utils.IUtils;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.data.constants.UniversalBtnStylesConst;
    import flash.events.Event;

    public class ConfirmMessageView extends MessageViewBase
    {

        public var btnExecute:UniversalBtn = null;

        public var btnCancel:UniversalBtn = null;

        public var costValue:AnimatedTextContainer = null;

        public var separator:MovieClip = null;

        public var inStorage:MessageStorageAmountContainer = null;

        public function ConfirmMessageView()
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
            var _loc1_:IUtils = App.utils;
            this.costValue.autoSize = TextFieldAutoSize.CENTER;
            this.btnExecute.addEventListener(ButtonEvent.CLICK,this.onBtnExecuteClickHandler);
            _loc1_.universalBtnStyles.setStyle(this.btnExecute,UniversalBtnStylesConst.STYLE_HEAVY_GREEN);
            this.btnCancel.label = BOOTCAMP.BTN_CANCEL;
            this.btnCancel.addEventListener(ButtonEvent.CLICK,this.onBtnCancelClickHandler);
            _loc1_.universalBtnStyles.setStyle(this.btnCancel,UniversalBtnStylesConst.STYLE_HEAVY_BLACK);
            animContainerTitle.gotoAndPlay(IN_STATE);
        }

        override protected function onDispose() : void
        {
            this.btnExecute.removeEventListener(ButtonEvent.CLICK,this.onBtnExecuteClickHandler);
            this.btnExecute.dispose();
            this.btnExecute = null;
            this.btnCancel.removeEventListener(ButtonEvent.CLICK,this.onBtnCancelClickHandler);
            this.btnCancel.dispose();
            this.btnCancel = null;
            this.costValue.dispose();
            this.costValue = null;
            this.separator = null;
            this.inStorage.dispose();
            this.inStorage = null;
            super.onDispose();
        }

        override protected function updateContent() : void
        {
            super.updateContent();
            this.costValue.htmlText = _messageData.costString;
            this.costValue.visible = _messageData.storageAmount == 0;
            this.inStorage.updateContent(_messageData.storageAmount);
            this.inStorage.visible = _messageData.storageAmount > 0;
            this.btnExecute.label = _messageData.labelExecute;
            this.btnExecute.enabled = _messageData.isExecuteEnabled;
            this.btnCancel.enabled = true;
        }

        override protected function playOutroAnimationStarted() : void
        {
            super.playOutroAnimationStarted();
            this.btnExecute.mouseEnabled = this.btnExecute.mouseChildren = false;
            this.btnCancel.mouseEnabled = this.btnCancel.mouseChildren = false;
        }

        private function onBtnExecuteClickHandler(param1:Event) : void
        {
            handleConfirm();
        }

        private function onBtnCancelClickHandler(param1:Event) : void
        {
            handleCancel();
        }
    }
}
