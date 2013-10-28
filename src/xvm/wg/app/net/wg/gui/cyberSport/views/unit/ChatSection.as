package net.wg.gui.cyberSport.views.unit
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import net.wg.gui.cyberSport.controls.ButtonDnmIcon;
   import net.wg.gui.messenger.ChannelComponent;
   import net.wg.gui.components.advanced.TextAreaSimple;
   import net.wg.gui.cyberSport.vo.UnitVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import flash.display.InteractiveObject;
   import flash.ui.Keyboard;
   import scaleform.clik.constants.InputValue;
   import org.idmedia.as3commons.util.StringUtils;
   import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
   import scaleform.clik.ui.InputDetails;
   import net.wg.gui.components.controls.SoundButtonEx;


   public class ChatSection extends UIComponent
   {
          
      public function ChatSection() {
         super();
         this.unitChannelComponent.sendButton = this.chatSubmitButton as SoundButtonEx;
         this.unitChannelComponent.messageArea.bgForm.alpha = 0;
         this.unitChannelComponent.messageArea.bgForm.visible = false;
      }

      private static const INVALID_EDIT_MODE:String = "invalidEditMode";

      public var lblChatHeader:TextField;

      public var chatSubmitButton:ButtonDnmIcon;

      public var editDescriptionButton:ButtonDnmIcon;

      public var editCommitButton:ButtonDnmIcon;

      public var unitChannelComponent:ChannelComponent;

      public var descriptionInput:TextAreaSimple;

      private var _unitData:UnitVO;

      private var _inEditMode:Boolean = false;

      private var _previousComment:String = "";

      public function get unitData() : UnitVO {
         return this._unitData;
      }

      public function set unitData(param1:UnitVO) : void {
         this._unitData = param1;
         invalidate(InvalidationType.DATA,INVALID_EDIT_MODE);
      }

      public function enableEditCommitButton(param1:Boolean) : void {
         if((this.editCommitButton) && (this.editDescriptionButton))
         {
            this.editDescriptionButton.enabled = param1;
            this.editCommitButton.enabled = param1;
         }
      }

      override protected function draw() : void {
         var _loc1_:String = null;
         var _loc2_:* = false;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._unitData?this._unitData.description:"";
            this.descriptionInput.text = _loc1_;
            this._previousComment = _loc1_;
         }
         if(isInvalid(INVALID_EDIT_MODE))
         {
            _loc2_ = this._unitData?this._unitData.isCommander:false;
            this.editDescriptionButton.visible = (_loc2_) && !this._inEditMode;
            this.editCommitButton.visible = (_loc2_) && (this._inEditMode);
            this.descriptionInput.editable = (_loc2_) && (this._inEditMode);
         }
      }

      override protected function configUI() : void {
         super.configUI();
         this.lblChatHeader.text = CYBERSPORT.WINDOW_UNIT_CHAT;
         this.descriptionInput.editable = false;
         this.editDescriptionButton.visible = false;
         this.editCommitButton.visible = false;
         this.editDescriptionButton.addEventListener(ButtonEvent.CLICK,this.onEditClick);
         this.editCommitButton.addEventListener(ButtonEvent.CLICK,this.onEditCommitClick);
         this.descriptionInput.addEventListener(InputEvent.INPUT,this.descriptionInputHandler);
         addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
         this.unitChannelComponent.messageArea.bgForm.alpha = 0;
         this.unitChannelComponent.messageArea.bgForm.visible = false;
      }

      private function onEditCommitClick(param1:ButtonEvent) : void {
         this.updateDescription(true);
      }

      private function onEditClick(param1:ButtonEvent) : void {
         this._inEditMode = true;
         invalidate(INVALID_EDIT_MODE);
         App.utils.scheduler.envokeInNextFrame(this.updateFocus,this.descriptionInput);
      }

      private function updateFocus(param1:InteractiveObject) : void {
         App.utils.focusHandler.setFocus(param1);
      }

      private function descriptionInputHandler(param1:InputEvent) : void {
         if(param1.details.code == Keyboard.ESCAPE && param1.details.value == InputValue.KEY_DOWN && (this._inEditMode))
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            this.updateDescription(false);
         }
         if(param1.details.code == Keyboard.ENTER && param1.details.value == InputValue.KEY_DOWN)
         {
            param1.handled = true;
            this.updateDescription(true);
         }
      }

      private function updateDescription(param1:Boolean=false) : void {
         if(param1)
         {
            this._previousComment = this.descriptionInput.text = StringUtils.trim(this.descriptionInput.text);
            dispatchEvent(new CSComponentEvent(CSComponentEvent.EDIT_UNIT_DESCRIPTION,this.descriptionInput.text));
         }
         else
         {
            this.descriptionInput.text = this._previousComment;
         }
         this._inEditMode = false;
         invalidate(INVALID_EDIT_MODE);
      }

      override public function handleInput(param1:InputEvent) : void {
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.F1 && _loc2_.value == InputValue.KEY_UP)
         {
            if(this.descriptionInput.focused == 0)
            {
               param1.handled = true;
               dispatchEvent(new CSComponentEvent(CSComponentEvent.SHOW_FAQ_WINDOW));
            }
         }
         super.handleInput(param1);
      }

      override public function dispose() : void {
         this.editDescriptionButton.removeEventListener(ButtonEvent.CLICK,this.onEditClick);
         this.editCommitButton.removeEventListener(ButtonEvent.CLICK,this.onEditClick);
         this.descriptionInput.removeEventListener(InputEvent.INPUT,this.descriptionInputHandler);
         removeEventListener(InputEvent.INPUT,this.handleInput,false);
         this.editDescriptionButton.dispose();
         this.editCommitButton.dispose();
         this.chatSubmitButton.dispose();
         this.unitChannelComponent.dispose();
         this.descriptionInput.dispose();
         super.dispose();
      }
   }

}