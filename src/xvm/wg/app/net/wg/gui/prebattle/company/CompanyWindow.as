package net.wg.gui.prebattle.company
{
    import net.wg.gui.prebattle.meta.impl.CompanyWindowMeta;
    import net.wg.gui.prebattle.meta.ICompanyWindowMeta;
    import net.wg.gui.prebattle.controls.TeamMemberRenderer;
    import net.wg.gui.interfaces.IButtonIconLoader;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.TextInput;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.controls.DropdownMenu;
    import net.wg.gui.components.controls.ScrollingListEx;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.components.controls.CheckBox;
    import net.wg.gui.prebattle.data.PlayerPrbInfoVO;
    import org.idmedia.as3commons.util.StringUtils;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.data.constants.VehicleTypes;
    import net.wg.data.Aliases;
    import net.wg.gui.lobby.messengerBar.WindowGeometryInBar;
    import net.wg.gui.events.MessengerBarEvent;
    import net.wg.gui.events.ListEventEx;
    import scaleform.clik.events.InputEvent;
    import scaleform.clik.events.FocusHandlerEvent;
    import scaleform.clik.events.ListEvent;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;
    import scaleform.clik.utils.Padding;
    import flash.events.Event;
    import net.wg.infrastructure.interfaces.IUserContextMenuGenerator;
    import scaleform.gfx.MouseEventEx;
    import net.wg.gui.prebattle.squad.SquadWindowCIGenerator;
    import net.wg.data.components.BattleSessionCIGenerator;
    import flash.ui.Keyboard;
    import scaleform.clik.constants.InputValue;
    
    public class CompanyWindow extends CompanyWindowMeta implements ICompanyWindowMeta
    {
        
        public function CompanyWindow()
        {
            this.unassignedDataProvider = new DataProvider();
            this.assignedDataProvider = new DataProvider();
            this.invalidVehicles = [];
            super();
        }
        
        public var hiddenItemRenderer:TeamMemberRenderer;
        
        public var levelTooltip:String;
        
        public var upAllButton:IButtonIconLoader;
        
        public var addToAssignBtn:IButtonIconLoader;
        
        public var removeFromAssignBtn:IButtonIconLoader;
        
        public var commitEditButton:IButtonIconLoader;
        
        public var downAllButton:IButtonIconLoader;
        
        public var editButton:IButtonIconLoader;
        
        public var limitsLabel:TextField;
        
        public var levelSPGTooltip:String;
        
        public var levelTotalTooltip:String;
        
        public var topBG:MovieClip;
        
        public var listTitle:MovieClip;
        
        public var commentInput:TextInput;
        
        public var commentText:TextField;
        
        public var crewStuffField:TextField;
        
        public var sumLevelLimitField:TextField;
        
        public var queueLabel:TextField;
        
        public var totalCurrentLevelField:TextField;
        
        public var heavyLevelField:TextField;
        
        public var mediumLevelField:TextField;
        
        public var lightLevelField:TextField;
        
        public var atspgLevelField:TextField;
        
        public var spgLevelField:TextField;
        
        public var topButtonsBG:MovieClip;
        
        public var leaveButton:SoundButtonEx;
        
        public var readyButton:SoundButtonEx;
        
        public var inviteButton:SoundButtonEx;
        
        public var division:DropdownMenu;
        
        public var unassignedList:ScrollingListEx;
        
        public var assignedList:ScrollingListEx;
        
        public var unassignedDataProvider:DataProvider;
        
        public var assignedDataProvider:DataProvider;
        
        public var isOpenCheckbox:CheckBox;
        
        public var _commentDefaultTextColor:uint = 4473918;
        
        private var _commentNormalTextColor:Number;
        
        private var _canSendInvite:Boolean;
        
        private var _canKickPlayer:Boolean;
        
        private var _canAssignPlayer:Boolean;
        
        private var _canChangeComment:Boolean;
        
        private var _canMakeOpenedClosed:Boolean;
        
        private var _canUnassignPlayer:Boolean = false;
        
        private var _isReadyBtnEnabled:Boolean = false;
        
        private var _isPlayerReady:Boolean = false;
        
        private var _isLeaveBtnEnabled:Boolean = false;
        
        private var _canChangeDivision:Boolean = false;
        
        private var editState:Boolean = false;
        
        private var isDefaultComment:Boolean = false;
        
        private var invalidVehicles:Array;
        
        private var _isPlayerCreator:Boolean = false;
        
        private var lastComment:String = "";
        
        private var buttonsUpdated:Boolean = false;
        
        override public function as_refreshPermissions() : void
        {
            this.updatePermissions();
        }
        
        override public function as_enableLeaveBtn(param1:Boolean) : void
        {
            this.updateLeaveBtn(param1);
        }
        
        override public function as_enableReadyBtn(param1:Boolean) : void
        {
            this.enableReadyButton(param1);
        }
        
        override public function as_toggleReadyBtn(param1:Boolean) : void
        {
            this.readyButton.label = param1?PREBATTLE.DIALOGS_BUTTONS_READY:PREBATTLE.DIALOGS_BUTTONS_NOTREADY;
        }
        
        override public function as_setPlayerState(param1:int, param2:Boolean, param3:Object) : void
        {
            var _loc8_:Object = null;
            var _loc4_:Array = [];
            var _loc5_:DataProvider = param2?DataProvider(this.assignedList.dataProvider):DataProvider(this.unassignedList.dataProvider);
            var _loc6_:uint = _loc5_.length;
            var _loc7_:* = 0;
            while(_loc7_ < _loc6_)
            {
                _loc8_ = _loc5_.requestItemAt(_loc7_);
                if(_loc8_.dbID == param3.dbID)
                {
                    _loc8_.state = param3.state;
                    _loc8_.vShortName = param3.vShortName;
                    _loc8_.vLevel = param3.vLevel;
                    _loc8_.icon = param3.icon;
                    _loc8_.vType = param3.vType;
                    _loc8_.igrType = param3.igrType;
                }
                _loc4_.push(_loc8_);
                _loc7_++;
            }
            if(param2)
            {
                this.updateAssignList(_loc4_);
            }
            else
            {
                this.updateUnassignList(_loc4_);
            }
        }
        
        override public function as_setCoolDownForReadyButton(param1:uint) : void
        {
            this.enableReadyButton(false);
            App.utils.scheduler.scheduleTask(this.enableReadyButton,param1 * 1000,true);
        }
        
        override public function as_setRosterList(param1:int, param2:Boolean, param3:Array) : void
        {
            var _loc5_:* = 0;
            var _loc6_:Object = null;
            var _loc7_:* = 0;
            var _loc4_:Array = [];
            if(param3.length > 0)
            {
                _loc5_ = param3.length;
                _loc7_ = 0;
                while(_loc7_ < _loc5_)
                {
                    _loc6_ = param3[_loc7_] as Object;
                    _loc6_["orderNumber"] = _loc7_ + 1;
                    _loc4_.push(new PlayerPrbInfoVO(_loc6_));
                    _loc7_++;
                }
            }
            if(param2)
            {
                this.updateAssignList(_loc4_);
            }
            else
            {
                this.updateUnassignList(_loc4_);
            }
            this.updateMoveButtons();
        }
        
        public function as_setComment(param1:String) : void
        {
            var param1:String = StringUtils.trim(param1);
            this.lastComment = param1;
            if(!param1)
            {
                if(canChangeCommentS())
                {
                    this.commentText.visible = true;
                    this.commentText.text = PREBATTLE.LABELS_COMPANY_DEFAULTCOMMENT;
                    this.isDefaultComment = true;
                    this.changeAlign(this.isDefaultComment);
                }
                else
                {
                    this.commentText.text = "";
                    this.commentText.visible = false;
                }
                return;
            }
            var _loc2_:Boolean = canChangeCommentS();
            if(param1 == "" && !_loc2_)
            {
                this.commentText.text = "";
                this.commentText.visible = false;
            }
            else if(param1 != "")
            {
                this.commentText.visible = true;
            }
            
            if(param1 == "")
            {
                param1 = PREBATTLE.LABELS_COMPANY_DEFAULTCOMMENT;
                this.isDefaultComment = true;
            }
            else
            {
                this.isDefaultComment = false;
            }
            this.commentText.text = param1;
            this.changeAlign(this.isDefaultComment);
            if((this.commentInput) && !this.isDefaultComment)
            {
                this.commentInput.text = param1;
                this.commentInput.enabled = _loc2_;
            }
        }
        
        public function as_setDivisionsList(param1:Array, param2:uint) : void
        {
            if(!this.division)
            {
                return;
            }
            this.division.dataProvider = new DataProvider(param1);
            this.division.labelField = "label";
            this.autoSelectDivision(param2);
            this.updateDivision();
            this.leaveButton.label = isPlayerCreatorS()?MESSENGER.DIALOGS_TEAMCHANNEL_BUTTONS_DISMISS:MESSENGER.DIALOGS_TEAMCHANNEL_BUTTONS_LEAVE;
            this.updateReadyButton();
        }
        
        public function as_setDivision(param1:uint) : void
        {
            this.autoSelectDivision(param1);
        }
        
        public function as_setOpened(param1:Boolean) : void
        {
            if(this.isOpenCheckbox)
            {
                this.isOpenCheckbox.removeEventListener(ButtonEvent.CLICK,this.handleIsOpenChange);
                this.isOpenCheckbox.selected = param1;
                this.isOpenCheckbox.enabled = canMakeOpenedClosedS();
                this.isOpenCheckbox.addEventListener(ButtonEvent.CLICK,this.handleIsOpenChange);
            }
        }
        
        public function as_setTotalLimitLabels(param1:String, param2:String) : void
        {
            this.sumLevelLimitField.htmlText = param2;
            this.totalCurrentLevelField.htmlText = param1;
        }
        
        public function as_setMaxCountLimitLabel(param1:String) : void
        {
            if(this.crewStuffField)
            {
                this.crewStuffField.htmlText = param1;
            }
        }
        
        public function as_setClassesLimits(param1:Array) : void
        {
            var _loc4_:Object = null;
            var _loc2_:uint = param1.length;
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                _loc4_ = param1[_loc3_];
                if(_loc4_.vehClass == VehicleTypes.HEAVY_TANK)
                {
                    this.heavyLevelField.htmlText = _loc4_.limit;
                }
                else if(_loc4_.vehClass == VehicleTypes.MEDIUM_TANK)
                {
                    this.mediumLevelField.htmlText = _loc4_.limit;
                }
                else if(_loc4_.vehClass == VehicleTypes.LIGHT_TANK)
                {
                    this.lightLevelField.htmlText = _loc4_.limit;
                }
                else if(_loc4_.vehClass == VehicleTypes.AT_SPG)
                {
                    this.atspgLevelField.htmlText = _loc4_.limit;
                }
                else if(_loc4_.vehClass == VehicleTypes.SPG)
                {
                    this.spgLevelField.htmlText = _loc4_.limit;
                }
                
                
                
                
                _loc3_++;
            }
        }
        
        public function as_setInvalidVehicles(param1:Array) : void
        {
            this.invalidVehicles = param1;
            this.refreshInvalidVehicles();
        }
        
        public function as_setChangeSettingCoolDown(param1:uint) : void
        {
            this.disableSettings(param1 * 1000);
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            registerComponent(channelComponent,Aliases.CHANNEL_COMPONENT);
            showWindowBgForm = false;
            window.useBottomBtns = true;
            canMinimize = true;
            canClose = true;
            enabledCloseBtn = false;
            isCentered = false;
            window.title = getCompanyNameS();
            this.updateWindowProperties();
            this.initComponentProperties();
            this.updatePermissions();
            geometry = new WindowGeometryInBar(MessengerBarEvent.PIN_CAROUSEL_WINDOW,getClientIDS());
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.upAllButton.iconSource = RES_ICONS.MAPS_ICONS_MESSENGER_ICONS_DOUBLE_RIGHT_ARROW_ICON;
            this.addToAssignBtn.iconSource = RES_ICONS.MAPS_ICONS_MESSENGER_ICONS_SINGLE_RIGHT_ARROW_ICON;
            this.removeFromAssignBtn.iconSource = RES_ICONS.MAPS_ICONS_MESSENGER_ICONS_SINGLE_LEFT_ARROW_ICON;
            this.downAllButton.iconSource = RES_ICONS.MAPS_ICONS_MESSENGER_ICONS_DOUBLE_LEFT_ARROW_ICON;
            this.commitEditButton.iconSource = RES_ICONS.MAPS_ICONS_MESSENGER_ICONS_ENTER;
            this.editButton.iconSource = RES_ICONS.MAPS_ICONS_MESSENGER_ICONS_EDIT;
            this.hiddenItemRenderer.visible = false;
            this.assignedList.labelField = "fullName";
            this.unassignedList.labelField = "fullName";
            this.unassignedList.dataProvider = this.unassignedDataProvider;
            this.unassignedList.selectedIndex = -1;
            this.unassignedList.addEventListener(ListEventEx.ITEM_CLICK,this.showAssignContextMenu);
            this.assignedList.addEventListener(ListEventEx.ITEM_CLICK,this.showAssignContextMenu);
            this.readyButton.addEventListener(ButtonEvent.CLICK,this.handleReadyClick);
            this.leaveButton.addEventListener(ButtonEvent.CLICK,this.handleLeaveClick);
            this._commentNormalTextColor = this.commentInput.textField.textColor;
            this.commentInput.defaultTextFormat.color = this._commentDefaultTextColor;
            this.commentInput.textField.textColor = this._commentDefaultTextColor;
            this.commentInput.defaultTextFormat.italic = false;
            this.commentInput.defaultText = PREBATTLE.LABELS_COMPANY_DEFAULTTEXT;
            this.commentInput.addEventListener(InputEvent.INPUT,this.commentInput_inputHandler);
            this.commentInput.addEventListener(FocusHandlerEvent.FOCUS_IN,this.handleFocusInCommentInput);
            if(this.listTitle)
            {
                this.listTitle.player.text = PREBATTLE.LABELS_PLAYER;
                this.listTitle.vehicle.text = PREBATTLE.LABELS_VEHICLE;
                this.listTitle.level.text = PREBATTLE.LABELS_LEVEL;
            }
            this.queueLabel.text = PREBATTLE.LABELS_COMPANY_QUEUE;
            this.limitsLabel.text = PREBATTLE.LABELS_COMPANY_LIMITS;
            this.addEventListener(InputEvent.INPUT,this.escInputHandler);
        }
        
        override protected function onDispose() : void
        {
            this.removeEventListener(InputEvent.INPUT,this.escInputHandler);
            this.commentInput.removeEventListener(FocusHandlerEvent.FOCUS_IN,this.handleFocusInCommentInput);
            this.commentInput.removeEventListener(InputEvent.INPUT,this.commentInput_inputHandler);
            this.commentInput.dispose();
            this.commitEditButton.removeEventListener(ButtonEvent.PRESS,this.handleCommitEditClick);
            this.commitEditButton.dispose();
            this.editButton.removeEventListener(ButtonEvent.PRESS,this.handleCommitEditClick);
            this.editButton.dispose();
            this.readyButton.removeEventListener(ButtonEvent.CLICK,this.handleReadyClick);
            this.readyButton.dispose();
            this.leaveButton.removeEventListener(ButtonEvent.CLICK,this.handleLeaveClick);
            this.leaveButton.dispose();
            this.inviteButton.removeEventListener(ButtonEvent.CLICK,this.onInviteBtnClick);
            this.inviteButton.dispose();
            if(this._canUnassignPlayer)
            {
                this.assignedList.removeEventListener(ListEventEx.ITEM_DOUBLE_CLICK,this.assignedList_itemDoubleClickHandler);
                this.removeFromAssignBtn.removeEventListener(ButtonEvent.CLICK,this.handleDownClick);
            }
            if(this._canAssignPlayer)
            {
                this.unassignedList.removeEventListener(ListEventEx.ITEM_DOUBLE_CLICK,this.handleMember17ItemDoubleClick);
                this.addToAssignBtn.removeEventListener(ButtonEvent.CLICK,this.handleUpClick);
            }
            this.unassignedList.removeEventListener(ListEventEx.ITEM_CLICK,this.showAssignContextMenu);
            this.unassignedList.dispose();
            this.unassignedDataProvider.cleanUp();
            this.unassignedDataProvider = null;
            this.assignedList.removeEventListener(ListEventEx.ITEM_CLICK,this.showAssignContextMenu);
            this.assignedList.dispose();
            this.assignedDataProvider.cleanUp();
            this.assignedDataProvider = null;
            if(this.division.hasEventListener(ListEvent.INDEX_CHANGE))
            {
                this.division.removeEventListener(ListEvent.INDEX_CHANGE,this.handleDivisionChange);
            }
            this.division.dispose();
            if(this.isOpenCheckbox.hasEventListener(ButtonEvent.CLICK))
            {
                this.isOpenCheckbox.removeEventListener(ButtonEvent.CLICK,this.handleIsOpenChange);
            }
            this.isOpenCheckbox.dispose();
            App.utils.scheduler.cancelTask(this.enableReadyButton);
            App.utils.scheduler.cancelTask(this.enableChangeSettings);
            App.utils.scheduler.cancelTask(setFocus);
            App.utils.scheduler.cancelTask(this.changeVisibleState);
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
        }
        
        private function updateLeaveBtn(param1:Boolean) : void
        {
            this.leaveButton.enabled = param1;
        }
        
        private function updateDivision() : void
        {
            this.division.enabled = this._canChangeDivision;
        }
        
        private function changeAlign(param1:Boolean) : void
        {
            var _loc2_:TextFormat = this.commentText.getTextFormat();
            _loc2_.align = param1?TextFormatAlign.RIGHT:TextFormatAlign.CENTER;
            this.commentText.setTextFormat(_loc2_);
        }
        
        private function updateCommentedStates(param1:Boolean = true) : void
        {
            var _loc3_:String = null;
            this.editState = !this.editState;
            var _loc2_:String = this.commentText.text;
            if(this.editState)
            {
                this.commentText.visible = false;
                this.forseSetTextToTextInput(this.lastComment);
                if(!this.commentInput.focused)
                {
                    App.utils.scheduler.envokeInNextFrame(setFocus,this.commentInput);
                }
                App.utils.scheduler.envokeInNextFrame(this.changeVisibleState);
            }
            else
            {
                this.changeVisibleState();
                this.commentText.visible = true;
                if(param1)
                {
                    _loc3_ = StringUtils.trim(this.commentInput.text);
                    if(_loc3_ != "")
                    {
                        this.commentText.text = this.commentInput.text;
                        this.lastComment = this.commentInput.text;
                        this.changeAlign(false);
                        this.isDefaultComment = false;
                    }
                    else
                    {
                        this.commentText.text = PREBATTLE.LABELS_COMPANY_DEFAULTCOMMENT;
                        this.changeAlign(true);
                        this.isDefaultComment = true;
                    }
                    this.commentInput.text = _loc3_;
                    this.lastComment = _loc3_;
                    requestToChangeCommentS(_loc3_);
                }
            }
            this.changeEditIcon(this.editState);
        }
        
        private function changeVisibleState() : void
        {
            if(this.commentInput.visible != this.editState)
            {
                this.commentInput.visible = this.editState;
            }
        }
        
        private function forseSetTextToTextInput(param1:String = "") : void
        {
            var _loc2_:uint = this.commentInput.textField.getTextFormat()["color"];
            if(_loc2_ == this._commentDefaultTextColor)
            {
                this.commentInput.textField.textColor = this._commentNormalTextColor;
                this.commentInput.text = param1;
            }
        }
        
        private function refreshInvalidVehicles() : void
        {
            this.updateVehicles(this.invalidVehicles,this.assignedList);
            this.updateVehicles(this.invalidVehicles,this.unassignedList);
        }
        
        private function updateVehicles(param1:Array, param2:ScrollingListEx) : void
        {
            var _loc5_:TeamMemberRenderer = null;
            var _loc3_:uint = param2.dataProvider.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                _loc5_ = param2.getRendererAt(_loc4_) as TeamMemberRenderer;
                if((_loc5_) && (_loc5_.model))
                {
                    _loc5_.isVehicleValid = param1.indexOf(_loc5_.model.accID) == -1;
                }
                _loc4_++;
            }
        }
        
        private function disableSettings(param1:uint) : void
        {
            this.enableChangeSettings(false);
            App.utils.scheduler.scheduleTask(this.enableChangeSettings,param1,true);
        }
        
        private function enableChangeSettings(param1:Boolean = false) : void
        {
            if(_baseDisposed)
            {
                return;
            }
            if(!param1)
            {
                if(this.commentInput.hasEventListener(InputEvent.INPUT))
                {
                    this.commentInput.removeEventListener(InputEvent.INPUT,this.commentInput_inputHandler);
                }
            }
            else
            {
                this.commentInput.addEventListener(InputEvent.INPUT,this.commentInput_inputHandler);
            }
            this.commitEditButton.enabled = param1;
            this.isOpenCheckbox.enabled = param1;
            if(param1)
            {
                this.division.enabled = this._canChangeDivision;
            }
            else
            {
                this.division.enabled = param1;
            }
        }
        
        private function requestToAssignImp(param1:Object) : void
        {
            if(this._canAssignPlayer)
            {
                requestToAssignS(param1.accID);
            }
        }
        
        private function requestToUnassignImp(param1:Object) : void
        {
            if(this._canUnassignPlayer)
            {
                requestToUnassignS(param1.accID);
            }
        }
        
        private function changeEditIcon(param1:Boolean) : void
        {
            var _loc2_:Boolean = this._canChangeComment;
            this.editButton.visible = (_loc2_) && !param1;
            this.commitEditButton.visible = (_loc2_) && (param1);
        }
        
        private function updateWindowProperties() : void
        {
            window.getIconMovie().gotoAndStop("team");
            var _loc1_:Padding = window.contentPadding as Padding;
            _loc1_.top = 40;
            _loc1_.left = 10;
            _loc1_.right = 10;
            _loc1_.bottom = 15;
        }
        
        private function initComponentProperties() : void
        {
            this._canSendInvite = false;
            this._canKickPlayer = false;
            this._canAssignPlayer = false;
            this._canChangeComment = false;
            this._canMakeOpenedClosed = false;
        }
        
        private function handleOverVehicleStats() : void
        {
            if(this.levelTooltip.length > 0)
            {
                App.toolTipMgr.showSpecial(this.levelTooltip,null);
            }
        }
        
        private function handleOutToolTip() : void
        {
            App.toolTipMgr.hide();
        }
        
        private function handleOverVehicleSPGStats() : void
        {
            if(this.levelSPGTooltip.length > 0)
            {
                App.toolTipMgr.showSpecial(this.levelSPGTooltip,null);
            }
        }
        
        private function handleOverTotalStats() : void
        {
            if(this.levelTotalTooltip.length > 0)
            {
                App.toolTipMgr.showSpecial(this.levelTotalTooltip,null);
            }
        }
        
        private function enableReadyButton(param1:Boolean) : void
        {
            this.readyButton.enabled = param1;
        }
        
        private function autoSelectDivision(param1:uint) : void
        {
            var _loc4_:Object = null;
            this.division.removeEventListener(ListEvent.INDEX_CHANGE,this.handleDivisionChange);
            var _loc2_:int = this.division.dataProvider.length;
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                _loc4_ = this.division.dataProvider.requestItemAt(_loc3_);
                if(_loc4_.data == param1)
                {
                    this.division.selectedIndex = _loc3_;
                }
                _loc3_++;
            }
            this.division.addEventListener(ListEvent.INDEX_CHANGE,this.handleDivisionChange);
        }
        
        private function updateMoveButtons() : void
        {
            if(this.addToAssignBtn)
            {
                this.addToAssignBtn.enabled = this.unassignedList.dataProvider.length > 0 && (this._canAssignPlayer);
                this.removeFromAssignBtn.enabled = this.assignedList.dataProvider.length > 0 && (this._canUnassignPlayer);
            }
        }
        
        private function updateAssignList(param1:Array) : void
        {
            this.assignedDataProvider = new DataProvider(param1);
            this.assignedList.dataProvider = this.assignedDataProvider;
            if(this.assignedList.selectedIndex == -1 && (this._isPlayerCreator))
            {
                this.assignedList.selectedIndex = 0;
            }
            this.assignedList.validateNow();
        }
        
        private function updateUnassignList(param1:Array) : void
        {
            this.unassignedDataProvider = new DataProvider(param1);
            this.unassignedList.dataProvider = this.unassignedDataProvider;
            if(this.unassignedList.selectedIndex == -1 && (this._isPlayerCreator))
            {
                this.unassignedList.selectedIndex = 0;
            }
            this.unassignedList.validateNow();
        }
        
        private function udpateOpenedCompany() : void
        {
            this.isOpenCheckbox.enabled = this._canMakeOpenedClosed;
        }
        
        private function updateCommentBtns() : void
        {
            if(this._canChangeComment)
            {
                this.commitEditButton.addEventListener(ButtonEvent.PRESS,this.handleCommitEditClick);
                this.editButton.addEventListener(ButtonEvent.PRESS,this.handleCommitEditClick);
                this.commitEditButton.enabled = true;
                this.clearCommentEditState();
            }
            else
            {
                if(this.isDefaultComment)
                {
                    this.commentText.text = "";
                }
                this.commentInput.visible = false;
                this.commentText.visible = true;
            }
        }
        
        private function clearCommentEditState() : void
        {
            this.editState = false;
            this.commentInput.visible = false;
            this.changeEditIcon(false);
            if(this.isDefaultComment)
            {
                this.commentText.text = PREBATTLE.LABELS_COMPANY_DEFAULTCOMMENT;
            }
            else
            {
                this.commentText.text = StringUtils.trim(this.lastComment) == ""?PREBATTLE.LABELS_COMPANY_DEFAULTCOMMENT:this.lastComment;
            }
            this.changeAlign(this.isDefaultComment);
            if((this._canChangeComment) && !this.isDefaultComment)
            {
                this.commentText.visible = true;
            }
        }
        
        private function updateAssignUnassignBtns() : void
        {
            if(this._canAssignPlayer)
            {
                this.unassignedList.useRightButton = true;
                this.unassignedList.addEventListener(ListEventEx.ITEM_DOUBLE_CLICK,this.handleMember17ItemDoubleClick);
                this.addToAssignBtn.addEventListener(ButtonEvent.CLICK,this.handleUpClick);
            }
            if(this._canUnassignPlayer)
            {
                this.assignedList.useRightButton = true;
                this.assignedList.addEventListener(ListEventEx.ITEM_DOUBLE_CLICK,this.assignedList_itemDoubleClickHandler);
                this.removeFromAssignBtn.addEventListener(ButtonEvent.CLICK,this.handleDownClick);
            }
            this.updateMoveButtons();
        }
        
        private function updateInviteBtn() : void
        {
            if(this._canSendInvite)
            {
                this.inviteButton.addEventListener(ButtonEvent.CLICK,this.onInviteBtnClick);
            }
            else if(this.inviteButton.hasEventListener(ButtonEvent.CLICK))
            {
                this.inviteButton.removeEventListener(ButtonEvent.CLICK,this.onInviteBtnClick);
            }
            
            if(this._isPlayerCreator)
            {
                this.inviteButton.enabled = this._canSendInvite;
            }
            else
            {
                this.inviteButton.visible = this._canSendInvite;
            }
        }
        
        private function updatePermissions() : void
        {
            this._canAssignPlayer = canMoveToAssignedS();
            this._canUnassignPlayer = canMoveToUnassignedS();
            this._canSendInvite = canSendInviteS();
            this._canChangeComment = canChangeCommentS();
            this._canKickPlayer = canKickPlayerS();
            this._canMakeOpenedClosed = canMakeOpenedClosedS();
            this._isReadyBtnEnabled = isReadyBtnEnabledS();
            this._isPlayerReady = isPlayerReadyS();
            this._isLeaveBtnEnabled = isLeaveBtnEnabledS();
            this._canChangeDivision = canChangeDivisionS();
            this._isPlayerCreator = isPlayerCreatorS();
            this.changeEditIcon(this.editState);
            this.updateReadyButton();
            this.enableReadyButton(this._isReadyBtnEnabled);
            this.updateMoveButtons();
            this.updateLeaveBtn(this._isLeaveBtnEnabled);
            this.updateInviteBtn();
            this.updateAssignUnassignBtns();
            if(!this.buttonsUpdated)
            {
                this.updateCommentBtns();
                this.buttonsUpdated = true;
            }
            this.updateDivision();
            this.udpateOpenedCompany();
        }
        
        private function updateReadyButton() : void
        {
            this.readyButton.label = this._isPlayerReady?PREBATTLE.DIALOGS_BUTTONS_NOTREADY:PREBATTLE.DIALOGS_BUTTONS_READY;
        }
        
        private function handleCommitEditClick(param1:ButtonEvent = null) : void
        {
            this.updateCommentedStates();
        }
        
        private function handleFocusInCommentInput(param1:FocusHandlerEvent = null) : void
        {
            this.forseSetTextToTextInput();
        }
        
        private function handleUpClick(param1:ButtonEvent = null) : void
        {
            var _loc2_:Object = null;
            if(this.unassignedList.dataProvider.length > 0)
            {
                if(this.unassignedList.selectedIndex > -1)
                {
                    _loc2_ = this.unassignedList.dataProvider[this.unassignedList.selectedIndex];
                    this.requestToAssignImp(_loc2_);
                    this.clearCommentEditState();
                }
            }
        }
        
        private function handleDownClick(param1:Event = null) : void
        {
            var _loc2_:Object = null;
            if(this.assignedList.dataProvider.length > 0)
            {
                if(this.assignedList.selectedIndex > -1)
                {
                    _loc2_ = this.assignedList.dataProvider[this.assignedList.selectedIndex];
                    this.requestToUnassignImp(_loc2_);
                    this.clearCommentEditState();
                }
            }
        }
        
        private function handleMember17ItemDoubleClick(param1:ListEventEx) : void
        {
            if(this.unassignedList.useRightButtonForSelect == false && param1.buttonIdx == 1)
            {
                return;
            }
            this.handleUpClick();
        }
        
        private function assignedList_itemDoubleClickHandler(param1:ListEventEx) : void
        {
            if(this.assignedList.useRightButtonForSelect == false && param1.buttonIdx == 1)
            {
                return;
            }
            this.handleDownClick();
        }
        
        private function showUnassignContextMenu(param1:ListEventEx) : void
        {
            var _loc2_:PlayerPrbInfoVO = null;
            var _loc3_:* = false;
            var _loc4_:IUserContextMenuGenerator = null;
            if(param1.buttonIdx == MouseEventEx.RIGHT_BUTTON)
            {
                _loc2_ = PlayerPrbInfoVO(param1.itemData);
                if(_loc2_.accID > -1)
                {
                    _loc3_ = _loc2_.dbID > -1;
                    _loc4_ = new SquadWindowCIGenerator(_loc3_,canKickPlayerS());
                    App.contextMenuMgr.showUserContextMenu(this,_loc2_,_loc4_);
                }
                else
                {
                    App.contextMenuMgr.hide();
                }
            }
        }
        
        private function showAssignContextMenu(param1:ListEventEx) : void
        {
            var _loc2_:* = false;
            var _loc3_:Object = null;
            var _loc4_:* = false;
            var _loc5_:IUserContextMenuGenerator = null;
            if(!param1.itemData)
            {
                return;
            }
            if(param1.buttonIdx == MouseEventEx.RIGHT_BUTTON)
            {
                _loc2_ = isPlayerCreatorS();
                _loc3_ = param1.itemData;
                if(_loc3_.accID > -1)
                {
                    _loc4_ = _loc3_.dbID > -1;
                    if(!_loc2_)
                    {
                        _loc5_ = new SquadWindowCIGenerator(_loc4_,canKickPlayerS(),true);
                    }
                    else
                    {
                        _loc5_ = new BattleSessionCIGenerator(_loc4_,canKickPlayerS());
                    }
                    App.contextMenuMgr.showUserContextMenu(this,_loc3_,_loc5_);
                }
                else
                {
                    App.contextMenuMgr.hide();
                }
            }
        }
        
        private function handleDivisionChange(param1:ListEvent) : void
        {
            if((this.division.enabled) && (param1.itemData))
            {
                requestToChangeDivisionS(param1.itemData.data);
                this.clearCommentEditState();
            }
        }
        
        private function handleLeaveClick(param1:ButtonEvent) : void
        {
            requestToLeaveS();
        }
        
        private function handleReadyClick(param1:ButtonEvent) : void
        {
            requestToReadyS(this.readyButton.label == PREBATTLE.DIALOGS_BUTTONS_READY);
            this.clearCommentEditState();
        }
        
        private function handleIsOpenChange(param1:ButtonEvent) : void
        {
            requestToChangeOpenedS(param1.target.selected);
            this.clearCommentEditState();
        }
        
        private function onInviteBtnClick(param1:ButtonEvent) : void
        {
            showPrebattleSendInvitesWindowS();
        }
        
        private function commentInput_inputHandler(param1:InputEvent) : void
        {
            if(param1.details.code == Keyboard.ESCAPE && param1.details.value == InputValue.KEY_DOWN && (this.editState))
            {
                param1.preventDefault();
                param1.stopImmediatePropagation();
                this.updateCommentedStates(false);
            }
            if(param1.details.code == Keyboard.ENTER && param1.details.value == InputValue.KEY_DOWN)
            {
                param1.handled = true;
                this.updateCommentedStates(true);
            }
        }
        
        private function escInputHandler(param1:InputEvent) : void
        {
            if(param1.details.code == Keyboard.ESCAPE && param1.details.value == InputValue.KEY_DOWN && (this.editState) && (this.commentInput.focused))
            {
                param1.preventDefault();
                param1.stopImmediatePropagation();
                this.updateCommentedStates(false);
            }
        }
        
        override public function handleInput(param1:InputEvent) : void
        {
            if(param1.details.code == Keyboard.F1 && param1.details.value == InputValue.KEY_UP && (this.editState) && (this.commentInput.focused))
            {
                return;
            }
            super.handleInput(param1);
        }
    }
}
