package net.wg.gui.lobby.dialogs 
{
    import flash.text.*;
    import flash.ui.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.tankman.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class DismissTankmanDialog extends net.wg.infrastructure.base.meta.impl.DismissTankmanDialogMeta implements net.wg.infrastructure.base.meta.IDismissTankmanDialogMeta
    {
        public function DismissTankmanDialog()
        {
            super();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (this.model && isInvalid(UPDATE_BLOCK)) 
                this.setData();
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            var loc1:*=window.contentPadding as scaleform.clik.utils.Padding;
            loc1.right = 14;
            this.errorMessage.visible = false;
            this.errorMessage.mouseEnabled = false;
            this.errorMessage.text = DIALOGS.PROTECTEDDISMISSTANKMAN_ERRORMESSAGE;
            return;
        }

        internal function updateFocus(arg1:scaleform.clik.core.UIComponent):void
        {
            App.utils.focusHandler.setFocus(arg1);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.controlText.addEventListener(scaleform.clik.events.InputEvent.INPUT, this.controlText_inputHandler);
            App.utils.scheduler.envokeInNextFrame(this.updateFocus, this.controlText);
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.controlText.removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.controlText_inputHandler);
            this.controlText.dispose();
            this.model.dispose();
            this.mainBlock.dispose();
            App.utils.scheduler.cancelTask(this.updateFocus);
            App.utils.scheduler.cancelTask(this.runtimeValidate);
            return;
        }

        public function as_enabledButton(arg1:Boolean):void
        {
            this.enabledButton = arg1;
            this.updateButton();
            return;
        }

        public function as_controlTextInput(arg1:String):void
        {
            this.controlNumber = arg1;
            return;
        }

        internal function updateButton():void
        {
            if (secondBtn.enabled != this.enabledButton) 
            {
                secondBtn.enabled = this.enabledButton;
                if (this.enabledButton) 
                {
                    this.showAlertState(false);
                    App.utils.scheduler.envokeInNextFrame(this.updateFocus, secondBtn);
                }
            }
            return;
        }

        public function as_tankMan(arg1:Object):void
        {
            if (arg1 == null) 
                return;
            this.model = net.wg.gui.lobby.tankman.SkillDropModel.parseFromObject(arg1);
            invalidate(UPDATE_BLOCK);
            return;
        }

        public function as_setQuestionForUser(arg1:String):void
        {
            if (arg1 == null) 
                return;
            this.questionForUser = arg1;
            invalidate(UPDATE_BLOCK);
            return;
        }

        internal function setData():void
        {
            this.updateButton();
            this.mainBlock.nation = this.model.nation;
            this.mainBlock.tankmanName = this.model.tankmanName;
            this.mainBlock.portraitSource = this.model.tankmanIcon;
            this.mainBlock.roleSource = this.model.roleIcon;
            this.mainBlock.setSkills(this.model.skillsCount, this.model.preLastSkill, this.model.lastSkill, this.model.lastSkillLevel, this.model.hasNewSkill);
            this.mainBlock.setRoleLevel(this.model.roleLevel);
            this.question.htmlText = this.questionForUser;
            return;
        }

        protected override function getBackgroundActualHeight():Number
        {
            return firstBtn.y + firstBtn.height;
        }

        internal function controlText_inputHandler(arg1:scaleform.clik.events.InputEvent):void
        {
            if (arg1.details.value == scaleform.clik.constants.InputValue.KEY_UP) 
            {
                this.showAlertState(false);
                App.utils.scheduler.cancelTask(this.runtimeValidate);
                if (arg1.details.code != flash.ui.Keyboard.ENTER) 
                    if (!this.isEmptyText) 
                        App.utils.scheduler.scheduleTask(this.runtimeValidate, AUTO_UPDATE_INTERVAL);
                else 
                    this.showAlertState(!this.isValidText);
                sendControlNumberS(this.controlText.text);
            }
            return;
        }

        internal function get isEmptyText():Boolean
        {
            return this.controlText.text == "";
        }

        internal function get isValidText():Boolean
        {
            return this.controlText.text == this.controlNumber;
        }

        internal function runtimeValidate():void
        {
            this.showAlertState(!this.isValidText);
            return;
        }

        internal function showAlertState(arg1:Boolean):void
        {
            this.controlText.highlight = arg1;
            this.errorMessage.visible = arg1;
            return;
        }

        internal static const UPDATE_BLOCK:String="updateBlock";

        internal static const AUTO_UPDATE_INTERVAL:int=3000;

        public var mainBlock:net.wg.gui.lobby.tankman.TankmanSkillsInfoBlock;

        public var question:flash.text.TextField;

        public var errorMessage:flash.text.TextField;

        public var model:net.wg.gui.lobby.tankman.SkillDropModel;

        public var controlText:net.wg.gui.components.controls.TextInput;

        internal var questionForUser:String="";

        internal var enabledButton:Boolean=false;

        internal var controlNumber:String="";
    }
}
