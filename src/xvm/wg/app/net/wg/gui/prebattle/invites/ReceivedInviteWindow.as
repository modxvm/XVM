package net.wg.gui.prebattle.invites
{
   import net.wg.gui.prebattle.meta.impl.ReceivedInviteWindowMeta;
   import net.wg.gui.prebattle.meta.IReceivedInviteWindowMeta;
   import net.wg.gui.components.advanced.TextAreaSimple;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.prebattle.data.ReceivedInviteVO;
   import scaleform.clik.utils.Padding;
   import scaleform.clik.events.ButtonEvent;
   
   public class ReceivedInviteWindow extends ReceivedInviteWindowMeta implements IReceivedInviteWindowMeta
   {
      
      public function ReceivedInviteWindow() {
         super();
      }
      
      private static const UPDATE_DATA:String = "updateData";
      
      private static const SIMPLE_INVITE_LABEL:String = "simple";
      
      private static const INVITE_WITH_NOTE_LABEL:String = "withNote";
      
      public var inviteTextArea:TextAreaSimple;
      
      public var messageTextArea:TextAreaSimple;
      
      public var noteTextField:TextField;
      
      public var inviteMessageLabel:TextField;
      
      public var inviteAddMessageLabel:TextField;
      
      public var acceptButton:SoundButtonEx;
      
      public var declineButton:SoundButtonEx;
      
      public var cancelButton:SoundButtonEx;
      
      private var inviteVO:ReceivedInviteVO = null;
      
      private var isUpdatedData:Boolean = true;
      
      public function as_setTitle(param1:String) : void {
         window.title = param1;
      }
      
      public function as_setReceivedInviteInfo(param1:Object) : void {
         this.inviteVO = new ReceivedInviteVO(param1);
         this.isUpdatedData = false;
         invalidate(UPDATE_DATA);
      }
      
      override protected function draw() : void {
         super.draw();
         if((isInvalid(UPDATE_DATA)) && !this.isUpdatedData)
         {
            this.isUpdatedData = true;
            this.updateComponents();
         }
      }
      
      override protected function onPopulate() : void {
         super.onPopulate();
         canClose = true;
         showWindowBg = false;
         window.useBottomBtns = true;
         isCentered = false;
         var _loc1_:Padding = window.contentPadding as Padding;
         _loc1_.bottom = 28;
         this.inviteMessageLabel.text = INVITES.GUI_LABELS_INVITETEXT;
         this.inviteAddMessageLabel.text = INVITES.GUI_LABELS_ADDITIONALTEXT;
      }
      
      override protected function configUI() : void {
         super.configUI();
         this.acceptButton.addEventListener(ButtonEvent.CLICK,this.acceptButton_buttonClickHandler);
         this.declineButton.addEventListener(ButtonEvent.CLICK,this.declineButton_buttonClickHandler);
         this.cancelButton.addEventListener(ButtonEvent.CLICK,this.cancelButton_buttonClickHandler);
         this.isUpdatedData = false;
         invalidate(UPDATE_DATA);
      }
      
      private function updateComponents() : void {
         if(!this.inviteVO)
         {
            return;
         }
         var _loc1_:String = SIMPLE_INVITE_LABEL;
         if(this.inviteVO.hasNote())
         {
            _loc1_ = INVITE_WITH_NOTE_LABEL;
         }
         if(_loc1_ != currentFrameLabel)
         {
            gotoAndStop(_loc1_);
         }
         if(this.inviteTextArea != null)
         {
            this.inviteTextArea.htmlText = this.inviteVO.text;
         }
         if(this.messageTextArea != null)
         {
            this.messageTextArea.htmlText = this.inviteVO.comment;
         }
         if(this.noteTextField != null)
         {
            this.noteTextField.text = this.inviteVO.note;
         }
         if(this.acceptButton != null)
         {
            this.acceptButton.visible = this.inviteVO.isAcceptVisible;
            this.acceptButton.enabled = this.inviteVO.canAccept;
            if((this.declineButton) && (this.inviteVO.isAcceptVisible) && !this.inviteVO.isDeclineVisible)
            {
               this.acceptButton.x = this.declineButton.x;
            }
         }
         if(this.declineButton != null)
         {
            this.declineButton.visible = this.inviteVO.isDeclineVisible;
            this.declineButton.enabled = this.inviteVO.canDecline;
         }
         setSize(actualWidth,actualHeight);
         window.validateNow();
         window.updateSize(width,height,true);
      }
      
      override protected function onDispose() : void {
         this.acceptButton.removeEventListener(ButtonEvent.CLICK,this.acceptButton_buttonClickHandler);
         this.declineButton.removeEventListener(ButtonEvent.CLICK,this.declineButton_buttonClickHandler);
         this.cancelButton.removeEventListener(ButtonEvent.CLICK,this.cancelButton_buttonClickHandler);
         super.onDispose();
      }
      
      private function acceptButton_buttonClickHandler(param1:ButtonEvent) : void {
         acceptInviteS();
      }
      
      private function declineButton_buttonClickHandler(param1:ButtonEvent) : void {
         declineInviteS();
      }
      
      private function cancelButton_buttonClickHandler(param1:ButtonEvent) : void {
         cancelInviteS();
      }
   }
}
