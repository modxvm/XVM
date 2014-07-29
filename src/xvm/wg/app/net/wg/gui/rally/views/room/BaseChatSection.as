package net.wg.gui.rally.views.room
{
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.interfaces.entity.IFocusContainer;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import net.wg.gui.components.advanced.ButtonDnmIcon;
    import net.wg.gui.messenger.ChannelComponent;
    import net.wg.gui.components.controls.TextInput;
    import net.wg.gui.rally.interfaces.IRallyVO;
    import scaleform.clik.constants.InvalidationType;
    import flash.display.InteractiveObject;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.events.InputEvent;
    import flash.text.TextFormat;
    import net.wg.infrastructure.events.FocusRequestEvent;
    import flash.ui.Keyboard;
    import scaleform.clik.constants.InputValue;
    import scaleform.clik.ui.InputDetails;
    import net.wg.gui.rally.events.RallyViewsEvent;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.infrastructure.interfaces.IUserProps;
    import net.wg.data.constants.Values;
    import flash.text.TextFormatAlign;
    
    public class BaseChatSection extends UIComponent implements IFocusContainer
    {
        
        public function BaseChatSection()
        {
            super();
            this.channelComponent.externalButton = this.chatSubmitButton;
            this.channelComponent.messageArea.bgForm.visible = false;
        }
        
        protected static var INVALID_EDIT_MODE:String = "invalidEditMode";
        
        private static function hideTooltip(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var lblChatHeader:TextField;
        
        public var chatSubmitButton:ButtonDnmIcon;
        
        public var editDescriptionButton:ButtonDnmIcon;
        
        public var editCommitButton:ButtonDnmIcon;
        
        public var channelComponent:ChannelComponent;
        
        public var descriptionInput:TextInput;
        
        protected var _rallyData:IRallyVO;
        
        protected var _inEditMode:Boolean = false;
        
        protected var _previousComment:String = "";
        
        public var descriptionTF:TextField;
        
        protected function getHeader() : String
        {
            return "";
        }
        
        public function get rallyData() : IRallyVO
        {
            return this._rallyData;
        }
        
        public function set rallyData(param1:IRallyVO) : void
        {
            if(param1 == null)
            {
                return;
            }
            this._rallyData = param1;
            invalidate(InvalidationType.DATA,INVALID_EDIT_MODE);
        }
        
        public function getComponentForFocus() : InteractiveObject
        {
            return this.descriptionInput;
        }
        
        public function enableEditCommitButton(param1:Boolean) : void
        {
            if((this.editCommitButton) && (this.editDescriptionButton))
            {
                this.editDescriptionButton.enabled = param1;
                this.editCommitButton.enabled = param1;
            }
        }
        
        public function setDescription(param1:String) : void
        {
            this.descriptionInput.text = param1;
            this.updateDescriptionTF(param1);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.lblChatHeader.text = this.getHeader();
            this.descriptionInput.editable = false;
            this.descriptionInput.defaultTextFormat = this.descriptionInput.textField.getTextFormat();
            this.descriptionInput.defaultTextFormat.italic = false;
            this.descriptionInput.defaultTextFormat.color = 5855568;
            this.editDescriptionButton.visible = false;
            this.editCommitButton.visible = false;
            this.editDescriptionButton.addEventListener(ButtonEvent.CLICK,this.onEditClick);
            this.editCommitButton.addEventListener(ButtonEvent.CLICK,this.onEditCommitClick);
            this.descriptionInput.addEventListener(InputEvent.INPUT,this.descriptionInputHandler);
            addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
            this.channelComponent.messageArea.bgForm.alpha = 0;
            this.channelComponent.messageArea.bgForm.visible = false;
            var _loc1_:TextFormat = this.descriptionInput.textField.getTextFormat();
            _loc1_.italic = false;
            _loc1_.color = 5855568;
            this.descriptionTF.setTextFormat(this.descriptionInput.textField.getTextFormat());
            this.descriptionTF.addEventListener(MouseEvent.ROLL_OVER,this.onDescriptionOver);
            this.descriptionTF.addEventListener(MouseEvent.ROLL_OUT,hideTooltip);
        }
        
        override protected function draw() : void
        {
            var _loc1_:String = null;
            var _loc2_:* = false;
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if(!this._inEditMode)
                {
                    _loc1_ = this._rallyData?this._rallyData.description:"";
                    this.descriptionInput.text = _loc1_;
                    this._previousComment = _loc1_;
                    this.updateDescriptionTF(this._previousComment);
                }
            }
            if(isInvalid(INVALID_EDIT_MODE))
            {
                _loc2_ = this._rallyData?this._rallyData.isCommander:false;
                this.editDescriptionButton.visible = (_loc2_) && !this._inEditMode;
                this.editCommitButton.visible = (_loc2_) && (this._inEditMode);
                this.descriptionInput.visible = this.descriptionInput.editable = (_loc2_) && (this._inEditMode);
                this.descriptionTF.visible = !this.descriptionInput.visible;
            }
        }
        
        override protected function onDispose() : void
        {
            this.editDescriptionButton.removeEventListener(ButtonEvent.CLICK,this.onEditClick);
            this.editCommitButton.removeEventListener(ButtonEvent.CLICK,this.onEditClick);
            this.descriptionInput.removeEventListener(InputEvent.INPUT,this.descriptionInputHandler);
            removeEventListener(InputEvent.INPUT,this.handleInput,false);
            this.descriptionTF.removeEventListener(MouseEvent.ROLL_OVER,this.onDescriptionOver);
            this.descriptionTF.removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
            this.descriptionTF = null;
            this.editDescriptionButton.dispose();
            this.editDescriptionButton = null;
            this.editCommitButton.dispose();
            this.editCommitButton = null;
            this.chatSubmitButton.dispose();
            this.chatSubmitButton = null;
            this.channelComponent = null;
            this.descriptionInput.dispose();
            this.descriptionInput = null;
            super.onDispose();
        }
        
        private function updateFocus() : void
        {
            dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
        }
        
        private function onEditCommitClick(param1:ButtonEvent) : void
        {
            this.updateDescription(true);
        }
        
        private function onEditClick(param1:ButtonEvent) : void
        {
            this._inEditMode = true;
            invalidate(INVALID_EDIT_MODE);
            App.utils.scheduler.envokeInNextFrame(this.updateFocus);
        }
        
        private function descriptionInputHandler(param1:InputEvent) : void
        {
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
        
        override public function handleInput(param1:InputEvent) : void
        {
            var _loc2_:InputDetails = param1.details;
            if(_loc2_.code == Keyboard.F1 && _loc2_.value == InputValue.KEY_UP)
            {
                if(this.descriptionInput.focused == 0)
                {
                    param1.handled = true;
                    dispatchEvent(new RallyViewsEvent(RallyViewsEvent.SHOW_FAQ_WINDOW));
                }
            }
            super.handleInput(param1);
        }
        
        private function onDescriptionOver(param1:MouseEvent) : void
        {
            var _loc2_:String = this._rallyData?this._rallyData.description:"";
            if(_loc2_)
            {
                App.toolTipMgr.show(_loc2_);
            }
        }
        
        protected function updateDescription(param1:Boolean = false) : void
        {
            if(param1)
            {
                this._previousComment = this.descriptionInput.text = StringUtils.trim(this.descriptionInput.text);
                this.updateDescriptionTF(this._previousComment);
                dispatchEvent(new RallyViewsEvent(RallyViewsEvent.EDIT_RALLY_DESCRIPTION,this.descriptionInput.text));
            }
            else
            {
                this.descriptionInput.text = this._previousComment;
                this.updateDescriptionTF(this._previousComment);
            }
            this._inEditMode = false;
            invalidate(INVALID_EDIT_MODE);
        }
        
        private function updateDescriptionTF(param1:String) : void
        {
            var _loc2_:IUserProps = App.utils.commons.getUserProps(param1);
            App.utils.commons.formatPlayerName(this.descriptionTF,_loc2_);
            if(!this.descriptionTF.text && (this.rallyData))
            {
                this.descriptionTF.text = this.rallyData.isCommander?CYBERSPORT.WINDOW_UNIT_DESCRIPTIONDEFAULT:Values.EMPTY_STR;
                this.changeAlign(true);
            }
            else
            {
                this.changeAlign(false);
            }
        }
        
        private function changeAlign(param1:Boolean) : void
        {
            var _loc2_:TextFormat = this.descriptionTF.getTextFormat();
            _loc2_.align = param1?TextFormatAlign.RIGHT:TextFormatAlign.LEFT;
            this.descriptionTF.setTextFormat(_loc2_);
        }
    }
}
