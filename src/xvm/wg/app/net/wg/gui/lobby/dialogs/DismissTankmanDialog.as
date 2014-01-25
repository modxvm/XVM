package net.wg.gui.lobby.dialogs
{
   import net.wg.infrastructure.base.meta.impl.DismissTankmanDialogMeta;
   import net.wg.infrastructure.base.meta.IDismissTankmanDialogMeta;
   import net.wg.gui.lobby.tankman.TankmanSkillsInfoBlock;
   import flash.text.TextField;
   import net.wg.gui.lobby.tankman.SkillDropModel;
   import net.wg.gui.components.controls.TextInput;
   import scaleform.clik.utils.Padding;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.constants.InputValue;
   import flash.ui.Keyboard;


   public class DismissTankmanDialog extends DismissTankmanDialogMeta implements IDismissTankmanDialogMeta
   {
          
      public function DismissTankmanDialog() {
         super();
      }

      private static const UPDATE_BLOCK:String = "updateBlock";

      private static const AUTO_UPDATE_INTERVAL:int = 3000;

      public var mainBlock:TankmanSkillsInfoBlock;

      public var question:TextField;

      public var errorMessage:TextField;

      public var model:SkillDropModel;

      public var controlText:TextInput;

      private var questionForUser:String = "";

      private var enabledButton:Boolean = false;

      private var controlNumber:String = "";

      private var protectedState:Boolean = true;

      private const SIMPLE_DIALOG_PADDING:int = -6;

      override protected function draw() : void {
         super.draw();
         if((this.model) && (isInvalid(UPDATE_BLOCK)))
         {
            this.setData();
         }
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         var _loc1_:Padding = window.contentPadding as Padding;
         _loc1_.right = 14;
         this.errorMessage.visible = false;
         this.errorMessage.mouseEnabled = false;
         this.errorMessage.text = DIALOGS.PROTECTEDDISMISSTANKMAN_ERRORMESSAGE;
      }

      private function updateFocus(param1:UIComponent) : void {
         setFocus(param1);
      }

      override protected function configUI() : void {
         super.configUI();
         if(this.protectedState)
         {
            this.controlText.addEventListener(InputEvent.INPUT,this.controlText_inputHandler);
            App.utils.scheduler.envokeInNextFrame(this.updateFocus,this.controlText);
         }
         else
         {
            App.utils.scheduler.envokeInNextFrame(this.updateFocus,secondBtn);
         }
      }

      override protected function onDispose() : void {
         super.onDispose();
         this.controlText.removeEventListener(InputEvent.INPUT,this.controlText_inputHandler);
         this.controlText.dispose();
         this.model.dispose();
         this.mainBlock.dispose();
         App.utils.scheduler.cancelTask(this.updateFocus);
         App.utils.scheduler.cancelTask(this.runtimeValidate);
      }

      public function as_enabledButton(param1:Boolean) : void {
         this.enabledButton = param1;
         this.updateButton();
      }

      public function as_controlTextInput(param1:String) : void {
         this.controlNumber = param1;
      }

      private function updateButton() : void {
         if(!(secondBtn.enabled == this.enabledButton) && (this.protectedState))
         {
            secondBtn.enabled = this.enabledButton;
            if(this.enabledButton)
            {
               this.showAlertState(false);
               App.utils.scheduler.envokeInNextFrame(this.updateFocus,secondBtn);
            }
         }
      }

      public function as_tankMan(param1:Object) : void {
         if(param1 == null)
         {
            return;
         }
         this.model = SkillDropModel.parseFromObject(param1);
         if(this.model.roleLevel < 100 && this.model.lastSkill == null && this.model.hasNewSkill == false)
         {
            this.protectedState = false;
            this.controlText.visible = false;
         }
         invalidate(UPDATE_BLOCK);
      }

      public function as_setQuestionForUser(param1:String) : void {
         if(param1 == null)
         {
            return;
         }
         this.questionForUser = param1;
         invalidate(UPDATE_BLOCK);
      }

      private function setData() : void {
         this.updateButton();
         this.mainBlock.nation = this.model.nation;
         this.mainBlock.tankmanName = this.model.tankmanName;
         this.mainBlock.portraitSource = this.model.tankmanIcon;
         this.mainBlock.roleSource = this.model.roleIcon;
         this.mainBlock.setSkills(this.protectedState?this.model.skillsCount:-1,this.model.preLastSkill,this.model.lastSkill,this.model.lastSkillLevel,this.model.hasNewSkill,this.model.newSkillsCount,this.model.lastNewSkillLevel);
         this.mainBlock.setRoleLevel(this.model.roleLevel);
         this.question.htmlText = this.questionForUser;
      }

      override protected function getBackgroundActualHeight() : Number {
         if(this.protectedState)
         {
            return firstBtn.y + firstBtn.height;
         }
         return this.question.y + this.question.height + this.SIMPLE_DIALOG_PADDING;
      }

      private function controlText_inputHandler(param1:InputEvent) : void {
         if(param1.details.value == InputValue.KEY_UP)
         {
            this.showAlertState(false);
            App.utils.scheduler.cancelTask(this.runtimeValidate);
            if(param1.details.code == Keyboard.ENTER)
            {
               this.showAlertState(!this.isValidText);
            }
            else
            {
               if(!this.isEmptyText)
               {
                  App.utils.scheduler.scheduleTask(this.runtimeValidate,AUTO_UPDATE_INTERVAL);
               }
            }
            sendControlNumberS(this.controlText.text);
         }
      }

      private function get isEmptyText() : Boolean {
         return this.controlText.text == "";
      }

      private function get isValidText() : Boolean {
         return this.controlText.text == this.controlNumber;
      }

      private function runtimeValidate() : void {
         this.showAlertState(!this.isValidText);
      }

      private function showAlertState(param1:Boolean) : void {
         this.controlText.highlight = param1;
         this.errorMessage.visible = param1;
      }
   }

}