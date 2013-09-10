package net.wg.gui.prebattle.invites 
{
    import flash.text.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.prebattle.data.*;
    import net.wg.gui.prebattle.meta.*;
    import net.wg.gui.prebattle.meta.impl.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class ReceivedInviteWindow extends net.wg.gui.prebattle.meta.impl.ReceivedInviteWindowMeta implements net.wg.gui.prebattle.meta.IReceivedInviteWindowMeta
    {
        public function ReceivedInviteWindow()
        {
            super();
            return;
        }

        public function as_setTitle(arg1:String):void
        {
            window.title = arg1;
            return;
        }

        public function as_setReceivedInviteInfo(arg1:Object):void
        {
            this.inviteVO = new net.wg.gui.prebattle.data.ReceivedInviteVO(arg1);
            this.isUpdatedData = false;
            invalidate(UPDATE_DATA);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(UPDATE_DATA) && !this.isUpdatedData) 
            {
                this.isUpdatedData = true;
                this.updateComponents();
            }
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            canClose = true;
            showWindowBg = false;
            window.useBottomBtns = true;
            isCentered = false;
            var loc1:*=window.contentPadding as scaleform.clik.utils.Padding;
            loc1.bottom = 28;
            this.inviteMessageLabel.text = INVITES.GUI_LABELS_INVITETEXT;
            this.inviteAddMessageLabel.text = INVITES.GUI_LABELS_ADDITIONALTEXT;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.acceptButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.acceptButton_buttonClickHandler);
            this.declineButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.declineButton_buttonClickHandler);
            this.cancelButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.cancelButton_buttonClickHandler);
            this.isUpdatedData = false;
            invalidate(UPDATE_DATA);
            return;
        }

        internal function updateComponents():void
        {
            if (!this.inviteVO) 
                return;
            var loc1:*=SIMPLE_INVITE_LABEL;
            if (this.inviteVO.hasNote()) 
                loc1 = INVITE_WITH_NOTE_LABEL;
            if (loc1 != currentFrameLabel) 
                gotoAndStop(loc1);
            if (this.inviteTextArea != null) 
                this.inviteTextArea.htmlText = this.inviteVO.text;
            if (this.messageTextArea != null) 
                this.messageTextArea.htmlText = this.inviteVO.comment;
            if (this.noteTextField != null) 
                this.noteTextField.text = this.inviteVO.note;
            var loc2:*=!isNaN(this.inviteVO.id) && (this.inviteVO.canAccept || this.inviteVO.canDecline);
            if (this.acceptButton != null) 
            {
                this.acceptButton.visible = loc2;
                this.acceptButton.enabled = this.inviteVO.canAccept;
            }
            if (this.declineButton != null) 
            {
                this.declineButton.visible = loc2;
                this.declineButton.enabled = this.inviteVO.canDecline;
            }
            setSize(actualWidth, actualHeight);
            window.validateNow();
            window.updateSize(width, height, true);
            return;
        }

        protected override function onDispose():void
        {
            this.acceptButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.acceptButton_buttonClickHandler);
            this.declineButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.declineButton_buttonClickHandler);
            this.cancelButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.cancelButton_buttonClickHandler);
            super.onDispose();
            return;
        }

        internal function acceptButton_buttonClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            acceptInviteS();
            return;
        }

        internal function declineButton_buttonClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            declineInviteS();
            return;
        }

        internal function cancelButton_buttonClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            cancelInviteS();
            return;
        }

        internal static const UPDATE_DATA:String="updateData";

        internal static const SIMPLE_INVITE_LABEL:String="simple";

        internal static const INVITE_WITH_NOTE_LABEL:String="withNote";

        public var inviteTextArea:net.wg.gui.components.advanced.TextAreaSimple;

        public var messageTextArea:net.wg.gui.components.advanced.TextAreaSimple;

        public var noteTextField:flash.text.TextField;

        public var inviteMessageLabel:flash.text.TextField;

        public var inviteAddMessageLabel:flash.text.TextField;

        public var acceptButton:net.wg.gui.components.controls.SoundButtonEx;

        public var declineButton:net.wg.gui.components.controls.SoundButtonEx;

        public var cancelButton:net.wg.gui.components.controls.SoundButtonEx;

        internal var inviteVO:net.wg.gui.prebattle.data.ReceivedInviteVO=null;

        internal var isUpdatedData:Boolean=true;
    }
}
