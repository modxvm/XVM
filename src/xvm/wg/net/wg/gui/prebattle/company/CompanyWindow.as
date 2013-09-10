package net.wg.gui.prebattle.company 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.ui.*;
    import net.wg.data.*;
    import net.wg.data.components.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.messengerBar.*;
    import net.wg.gui.messenger.*;
    import net.wg.gui.prebattle.controls.*;
    import net.wg.gui.prebattle.data.*;
    import net.wg.gui.prebattle.meta.*;
    import net.wg.gui.prebattle.meta.impl.*;
    import net.wg.gui.prebattle.squad.*;
    import net.wg.infrastructure.interfaces.*;
    import org.idmedia.as3commons.util.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    import scaleform.gfx.*;
    
    public class CompanyWindow extends net.wg.gui.prebattle.meta.impl.CompanyWindowMeta implements net.wg.gui.prebattle.meta.ICompanyWindowMeta
    {
        public function CompanyWindow()
        {
            this.unassignedDataProvider = new scaleform.clik.data.DataProvider();
            this.assignedDataProvider = new scaleform.clik.data.DataProvider();
            this.invalidVehicles = [];
            super();
            return;
        }

        public function as_setDivision(arg1:uint):void
        {
            this.autoSelectDivision(arg1);
            return;
        }

        public function as_setOpened(arg1:Boolean):void
        {
            if (this.isOpenCheckbox) 
            {
                this.isOpenCheckbox.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleIsOpenChange);
                this.isOpenCheckbox.selected = arg1;
                this.isOpenCheckbox.enabled = canMakeOpenedClosedS();
                this.isOpenCheckbox.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleIsOpenChange);
            }
            return;
        }

        internal function changeAlign(arg1:Boolean):void
        {
            var loc1:*=this.commentText.getTextFormat();
            loc1.align = arg1 ? flash.text.TextFormatAlign.RIGHT : flash.text.TextFormatAlign.CENTER;
            this.commentText.setTextFormat(loc1);
            return;
        }

        public function as_setTotalLimitLabels(arg1:String, arg2:String):void
        {
            this.sumLevelLimitField.htmlText = arg2;
            this.totalCurrentLevelField.htmlText = arg1;
            return;
        }

        public function as_setMaxCountLimitLabel(arg1:String):void
        {
            if (this.crewStuffField) 
            {
                this.crewStuffField.htmlText = arg1;
            }
            return;
        }

        public function as_setClassesLimits(arg1:Array):void
        {
            var loc3:*=null;
            var loc1:*=arg1.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if ((loc3 = arg1[loc2]).vehClass != net.wg.data.constants.VehicleTypes.HEAVY_TANK) 
                {
                    if (loc3.vehClass != net.wg.data.constants.VehicleTypes.MEDIUM_TANK) 
                    {
                        if (loc3.vehClass != net.wg.data.constants.VehicleTypes.LIGHT_TANK) 
                        {
                            if (loc3.vehClass != net.wg.data.constants.VehicleTypes.AT_SPG) 
                            {
                                if (loc3.vehClass == net.wg.data.constants.VehicleTypes.SPG) 
                                {
                                    this.spgLevelField.htmlText = loc3.limit;
                                }
                            }
                            else 
                            {
                                this.atspgLevelField.htmlText = loc3.limit;
                            }
                        }
                        else 
                        {
                            this.lightLevelField.htmlText = loc3.limit;
                        }
                    }
                    else 
                    {
                        this.mediumLevelField.htmlText = loc3.limit;
                    }
                }
                else 
                {
                    this.heavyLevelField.htmlText = loc3.limit;
                }
                ++loc2;
            }
            return;
        }

        public function as_setInvalidVehicles(arg1:Array):void
        {
            this.invalidVehicles = arg1;
            this.refreshInvalidVehicles();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        internal function updateFocus(arg1:flash.display.InteractiveObject):void
        {
            App.utils.focusHandler.setFocus(arg1);
            return;
        }

        internal function handleCommitEditClick(arg1:scaleform.clik.events.ButtonEvent=null):void
        {
            this.updateCommentedStates();
            return;
        }

        internal function updateCommentedStates(arg1:Boolean=true):void
        {
            var loc2:*=null;
            this.editState = !this.editState;
            var loc1:*=this.commentText.text;
            if (this.editState) 
            {
                this.commentText.visible = false;
                this.forseSetTextToTextInput(this.lastComment);
                if (!this.commentInput.focused) 
                {
                    App.utils.scheduler.envokeInNextFrame(this.updateFocus, this.commentInput);
                }
                App.utils.scheduler.envokeInNextFrame(this.changeVisibleState);
            }
            else 
            {
                this.changeVisibleState();
                this.commentText.visible = true;
                if (arg1) 
                {
                    loc2 = org.idmedia.as3commons.util.StringUtils.trim(this.commentInput.text);
                    if (loc2 == "") 
                    {
                        this.commentText.text = PREBATTLE.LABELS_COMPANY_DEFAULTCOMMENT;
                        this.changeAlign(true);
                        this.isDefaultComment = true;
                    }
                    else 
                    {
                        this.commentText.text = this.commentInput.text;
                        this.lastComment = this.commentInput.text;
                        this.changeAlign(false);
                        this.isDefaultComment = false;
                    }
                    this.commentInput.text = loc2;
                    this.lastComment = loc2;
                    requestToChangeCommentS(loc2);
                }
            }
            this.changeEditIcon(this.editState);
            return;
        }

        internal function changeVisibleState():void
        {
            if (this.commentInput.visible != this.editState) 
            {
                this.commentInput.visible = this.editState;
            }
            return;
        }

        internal function handleFocusInCommentInput(arg1:scaleform.clik.events.FocusHandlerEvent=null):void
        {
            this.forseSetTextToTextInput();
            return;
        }

        internal function forseSetTextToTextInput(arg1:String=""):void
        {
            var loc1:*=this.commentInput.textField.getTextFormat()["color"];
            if (loc1 == this._commentDefaultTextColor) 
            {
                this.commentInput.textField.textColor = this._commentNormalTextColor;
                this.commentInput.text = arg1;
            }
            return;
        }

        public function as_setChangeSettingCoolDown(arg1:uint):void
        {
            this.disableSettings(arg1 * 1000);
            return;
        }

        internal function refreshInvalidVehicles():void
        {
            this.updateVehicles(this.invalidVehicles, this.assignedList);
            this.updateVehicles(this.invalidVehicles, this.unassignedList);
            return;
        }

        internal function updateVehicles(arg1:Array, arg2:net.wg.gui.components.controls.ScrollingListEx):void
        {
            var loc3:*=null;
            var loc1:*=arg2.dataProvider.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if ((loc3 = arg2.getRendererAt(loc2) as net.wg.gui.prebattle.controls.TeamMemberRenderer) && loc3.model) 
                {
                    loc3.isVehicleValid = arg1.indexOf(loc3.model.accID) == -1;
                }
                ++loc2;
            }
            return;
        }

        internal function disableSettings(arg1:uint):void
        {
            this.enableChangeSettings(false);
            App.utils.scheduler.scheduleTask(this.enableChangeSettings, arg1, true);
            return;
        }

        internal function enableChangeSettings(arg1:Boolean=false):void
        {
            if (arg1) 
            {
                this.commentInput.addEventListener(scaleform.clik.events.InputEvent.INPUT, this.commentInput_inputHandler);
            }
            else if (this.commentInput.hasEventListener(scaleform.clik.events.InputEvent.INPUT)) 
            {
                this.commentInput.removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.commentInput_inputHandler);
            }
            this.commitEditButton.enabled = arg1;
            this.isOpenCheckbox.enabled = arg1;
            if (arg1) 
            {
                this.division.enabled = this._canChangeDivision;
            }
            else 
            {
                this.division.enabled = arg1;
            }
            return;
        }

        internal function handleUpClick(arg1:scaleform.clik.events.ButtonEvent=null):void
        {
            var loc1:*=null;
            if (this.unassignedList.dataProvider.length > 0) 
            {
                if (this.unassignedList.selectedIndex > -1) 
                {
                    loc1 = this.unassignedList.dataProvider[this.unassignedList.selectedIndex];
                    this.requestToAssignImp(loc1);
                    this.clearCommentEditState();
                }
            }
            return;
        }

        internal function handleDownClick(arg1:flash.events.Event=null):void
        {
            var loc1:*=null;
            if (this.assignedList.dataProvider.length > 0) 
            {
                if (this.assignedList.selectedIndex > -1) 
                {
                    loc1 = this.assignedList.dataProvider[this.assignedList.selectedIndex];
                    this.requestToUnassignImp(loc1);
                    this.clearCommentEditState();
                }
            }
            return;
        }

        internal function handleMember17ItemDoubleClick(arg1:net.wg.gui.events.ListEventEx):void
        {
            if (this.unassignedList.useRightButtonForSelect == false && arg1.buttonIdx == 1) 
            {
                return;
            }
            this.handleUpClick();
            return;
        }

        internal function assignedList_itemDoubleClickHandler(arg1:net.wg.gui.events.ListEventEx):void
        {
            if (this.assignedList.useRightButtonForSelect == false && arg1.buttonIdx == 1) 
            {
                return;
            }
            this.handleDownClick();
            return;
        }

        internal function requestToAssignImp(arg1:Object):void
        {
            if (this._canAssignPlayer) 
            {
                requestToAssignS(arg1.accID);
            }
            return;
        }

        internal function requestToUnassignImp(arg1:Object):void
        {
            if (this._canUnassignPlayer) 
            {
                requestToUnassignS(arg1.accID);
            }
            return;
        }

        internal function showUnassignContextMenu(arg1:net.wg.gui.events.ListEventEx):void
        {
            var loc1:*=null;
            var loc2:*=false;
            var loc3:*=null;
            if (arg1.buttonIdx == scaleform.gfx.MouseEventEx.RIGHT_BUTTON) 
            {
                loc1 = net.wg.gui.prebattle.data.PlayerPrbInfoVO(arg1.itemData);
                if (loc1.accID > -1) 
                {
                    loc2 = loc1.uid > -1;
                    loc3 = new net.wg.gui.prebattle.squad.SquadWindowCIGenerator(loc2, canKickPlayerS());
                    App.contextMenuMgr.showUserContextMenu(this, loc1, loc3);
                }
                else 
                {
                    App.contextMenuMgr.hide();
                }
            }
            return;
        }

        internal function showAssignContextMenu(arg1:net.wg.gui.events.ListEventEx):void
        {
            var loc1:*=false;
            var loc2:*=null;
            var loc3:*=false;
            var loc4:*=null;
            if (!arg1.itemData) 
            {
                return;
            }
            if (arg1.buttonIdx == scaleform.gfx.MouseEventEx.RIGHT_BUTTON) 
            {
                loc1 = isPlayerCreatorS();
                loc2 = arg1.itemData;
                if (loc2.accID > -1) 
                {
                    loc3 = loc2.uid > -1;
                    if (loc1) 
                    {
                        loc4 = new net.wg.data.components.BattleSessionCIGenerator(loc3, canKickPlayerS());
                    }
                    else 
                    {
                        loc4 = new net.wg.gui.prebattle.squad.SquadWindowCIGenerator(loc3, canKickPlayerS(), true);
                    }
                    App.contextMenuMgr.showUserContextMenu(this, loc2, loc4);
                }
                else 
                {
                    App.contextMenuMgr.hide();
                }
            }
            return;
        }

        internal function changeEditIcon(arg1:Boolean):void
        {
            var loc1:*=this._canChangeComment;
            this.editButton.visible = loc1 && !arg1;
            this.commitEditButton.visible = loc1 && arg1;
            return;
        }

        internal function updateWindowProperties():void
        {
            window.getIconMovie().gotoAndStop("team");
            var loc1:*=window.contentPadding as scaleform.clik.utils.Padding;
            loc1.top = 40;
            loc1.left = 10;
            loc1.right = 10;
            loc1.bottom = 15;
            return;
        }

        internal function initComponentProperties():void
        {
            this._canSendInvite = false;
            this._canKickPlayer = false;
            this._canAssignPlayer = false;
            this._canChangeComment = false;
            this._canMakeOpenedClosed = false;
            return;
        }

        internal function handleDivisionChange(arg1:scaleform.clik.events.ListEvent):void
        {
            if (this.division.enabled && arg1.itemData) 
            {
                requestToChangeDivisionS(arg1.itemData.data);
                this.clearCommentEditState();
            }
            return;
        }

        internal function handleLeaveClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            requestToLeaveS();
            return;
        }

        internal function handleReadyClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            requestToReadyS(this.readyButton.label == PREBATTLE.DIALOGS_BUTTONS_READY);
            this.clearCommentEditState();
            return;
        }

        internal function handleIsOpenChange(arg1:scaleform.clik.events.ButtonEvent):void
        {
            requestToChangeOpenedS(arg1.target.selected);
            this.clearCommentEditState();
            return;
        }

        internal function onInviteBtnClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            showPrebattleSendInvitesWindowS();
            return;
        }

        internal function handleOverVehicleStats():void
        {
            if (this.levelTooltip.length > 0) 
            {
                App.toolTipMgr.showSpecial(this.levelTooltip, null);
            }
            return;
        }

        internal function handleOutToolTip():void
        {
            App.toolTipMgr.hide();
            return;
        }

        internal function handleOverTotalStats():void
        {
            if (this.levelTotalTooltip.length > 0) 
            {
                App.toolTipMgr.showSpecial(this.levelTotalTooltip, null);
            }
            return;
        }

        internal function enableReadyButton(arg1:Boolean):void
        {
            this.readyButton.enabled = arg1;
            return;
        }

        internal function autoSelectDivision(arg1:uint):void
        {
            var loc3:*=null;
            this.division.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.handleDivisionChange);
            var loc1:*=this.division.dataProvider.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if ((loc3 = this.division.dataProvider.requestItemAt(loc2)).data == arg1) 
                {
                    this.division.selectedIndex = loc2;
                }
                ++loc2;
            }
            this.division.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.handleDivisionChange);
            return;
        }

        internal function updateMoveButtons():void
        {
            if (this.addToAssignBtn) 
            {
                this.addToAssignBtn.enabled = this.unassignedList.dataProvider.length > 0 && this._canAssignPlayer;
                this.removeFromAssignBtn.enabled = this.assignedList.dataProvider.length > 0 && this._canUnassignPlayer;
            }
            return;
        }

        internal function updateAssignList(arg1:Array):void
        {
            this.assignedDataProvider = new scaleform.clik.data.DataProvider(arg1);
            this.assignedList.dataProvider = this.assignedDataProvider;
            if (this.assignedList.selectedIndex == -1 && this._isPlayerCreator) 
            {
                this.assignedList.selectedIndex = 0;
            }
            this.assignedList.validateNow();
            return;
        }

        internal function updateUnassignList(arg1:Array):void
        {
            this.unassignedDataProvider = new scaleform.clik.data.DataProvider(arg1);
            this.unassignedList.dataProvider = this.unassignedDataProvider;
            if (this.unassignedList.selectedIndex == -1 && this._isPlayerCreator) 
            {
                this.unassignedList.selectedIndex = 0;
            }
            this.unassignedList.validateNow();
            return;
        }

        internal function commentInput_inputHandler(arg1:scaleform.clik.events.InputEvent):void
        {
            if (arg1.details.code == flash.ui.Keyboard.ESCAPE && arg1.details.value == scaleform.clik.constants.InputValue.KEY_DOWN && this.editState) 
            {
                arg1.preventDefault();
                arg1.stopImmediatePropagation();
                this.updateCommentedStates(false);
            }
            if (arg1.details.code == flash.ui.Keyboard.ENTER && arg1.details.value == scaleform.clik.constants.InputValue.KEY_DOWN) 
            {
                arg1.handled = true;
                this.updateCommentedStates(true);
            }
            return;
        }

        internal function udpateOpenedCompany():void
        {
            this.isOpenCheckbox.enabled = this._canMakeOpenedClosed;
            return;
        }

        internal function updateLeaveBtn(arg1:Boolean):void
        {
            this.leaveButton.enabled = arg1;
            return;
        }

        internal function updateCommentBtns():void
        {
            if (this._canChangeComment) 
            {
                this.commitEditButton.addEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.handleCommitEditClick);
                this.editButton.addEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.handleCommitEditClick);
                this.commitEditButton.enabled = true;
                this.clearCommentEditState();
            }
            else 
            {
                if (this.isDefaultComment) 
                {
                    this.commentText.text = "";
                }
                this.commentInput.visible = false;
                this.commentText.visible = true;
            }
            return;
        }

        internal function clearCommentEditState():void
        {
            this.editState = false;
            this.commentInput.visible = false;
            this.changeEditIcon(false);
            if (this.isDefaultComment) 
            {
                this.commentText.text = PREBATTLE.LABELS_COMPANY_DEFAULTCOMMENT;
            }
            else 
            {
                this.commentText.text = org.idmedia.as3commons.util.StringUtils.trim(this.lastComment) != "" ? this.lastComment : PREBATTLE.LABELS_COMPANY_DEFAULTCOMMENT;
            }
            this.changeAlign(this.isDefaultComment);
            if (this._canChangeComment && !this.isDefaultComment) 
            {
                this.commentText.visible = true;
            }
            return;
        }

        internal function updateAssignUnassignBtns():void
        {
            if (this._canAssignPlayer) 
            {
                this.unassignedList.useRightButton = true;
                this.unassignedList.addEventListener(net.wg.gui.events.ListEventEx.ITEM_DOUBLE_CLICK, this.handleMember17ItemDoubleClick);
                this.addToAssignBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleUpClick);
            }
            if (this._canUnassignPlayer) 
            {
                this.assignedList.useRightButton = true;
                this.assignedList.addEventListener(net.wg.gui.events.ListEventEx.ITEM_DOUBLE_CLICK, this.assignedList_itemDoubleClickHandler);
                this.removeFromAssignBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleDownClick);
            }
            this.updateMoveButtons();
            return;
        }

        internal function updateInviteBtn():void
        {
            if (this._canSendInvite) 
            {
                this.inviteButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onInviteBtnClick);
            }
            else if (this.inviteButton.hasEventListener(scaleform.clik.events.ButtonEvent.CLICK)) 
            {
                this.inviteButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onInviteBtnClick);
            }
            if (this._isPlayerCreator) 
            {
                this.inviteButton.enabled = this._canSendInvite;
            }
            else 
            {
                this.inviteButton.visible = this._canSendInvite;
            }
            return;
        }

        internal function updatePermissions():void
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
            if (!this.buttonsUpdated) 
            {
                this.updateCommentBtns();
                this.buttonsUpdated = true;
            }
            this.updateDivision();
            this.udpateOpenedCompany();
            return;
        }

        internal function updateReadyButton():void
        {
            this.readyButton.label = this._isPlayerReady ? PREBATTLE.DIALOGS_BUTTONS_NOTREADY : PREBATTLE.DIALOGS_BUTTONS_READY;
            return;
        }

        internal function escInputHandler(arg1:scaleform.clik.events.InputEvent):void
        {
            if (arg1.details.code == flash.ui.Keyboard.ESCAPE && arg1.details.value == scaleform.clik.constants.InputValue.KEY_DOWN && this.editState && this.commentInput.focused) 
            {
                arg1.preventDefault();
                arg1.stopImmediatePropagation();
                this.updateCommentedStates(false);
            }
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            registerComponent(this.channelComponent, net.wg.data.Aliases.CHANNEL_COMPONENT);
            showWindowBg = false;
            window.useBottomBtns = true;
            canMinimize = true;
            canClose = true;
            enabledCloseBtn = false;
            isCentered = false;
            window.title = getCompanyName();
            this.updateWindowProperties();
            this.initComponentProperties();
            this.updatePermissions();
            geometry = new net.wg.gui.lobby.messengerBar.WindowGeometryInBar(net.wg.gui.events.MessengerBarEvent.PIN_CAROUSEL_WINDOW, getClientIDS());
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.hiddenItemRenderer.visible = false;
            this.assignedList.labelField = "fullName";
            this.unassignedList.labelField = "fullName";
            this.unassignedList.dataProvider = this.unassignedDataProvider;
            this.unassignedList.selectedIndex = -1;
            this.unassignedList.addEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.showAssignContextMenu);
            this.assignedList.addEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.showAssignContextMenu);
            this.readyButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleReadyClick);
            this.leaveButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleLeaveClick);
            this._commentNormalTextColor = this.commentInput.textField.textColor;
            this.commentInput.defaultTextFormat.color = this._commentDefaultTextColor;
            this.commentInput.textField.textColor = this._commentDefaultTextColor;
            this.commentInput.defaultTextFormat.italic = false;
            this.commentInput.defaultText = PREBATTLE.LABELS_COMPANY_DEFAULTTEXT;
            this.commentInput.addEventListener(scaleform.clik.events.InputEvent.INPUT, this.commentInput_inputHandler);
            this.commentInput.addEventListener(scaleform.clik.events.FocusHandlerEvent.FOCUS_IN, this.handleFocusInCommentInput);
            if (this.listTitle) 
            {
                this.listTitle.player.text = PREBATTLE.LABELS_PLAYER;
                this.listTitle.vehicle.text = PREBATTLE.LABELS_VEHICLE;
                this.listTitle.level.text = PREBATTLE.LABELS_LEVEL;
            }
            this.queueLabel.text = PREBATTLE.LABELS_COMPANY_QUEUE;
            this.limitsLabel.text = PREBATTLE.LABELS_COMPANY_LIMITS;
            this.addEventListener(scaleform.clik.events.InputEvent.INPUT, this.escInputHandler);
            return;
        }

        public override function setFocus():void
        {
            super.setFocus();
            if (this.channelComponent) 
            {
                this.channelComponent.setFocusToInput();
            }
            return;
        }

        public override function as_refreshPermissions():void
        {
            this.updatePermissions();
            return;
        }

        protected override function onDispose():void
        {
            this.removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.escInputHandler);
            this.commentInput.removeEventListener(scaleform.clik.events.FocusHandlerEvent.FOCUS_IN, this.handleFocusInCommentInput);
            this.commentInput.removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.commentInput_inputHandler);
            this.commentInput.dispose();
            this.commitEditButton.removeEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.handleCommitEditClick);
            this.commitEditButton.dispose();
            this.editButton.removeEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.handleCommitEditClick);
            this.editButton.dispose();
            this.readyButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleReadyClick);
            this.readyButton.dispose();
            this.leaveButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleLeaveClick);
            this.leaveButton.dispose();
            this.inviteButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onInviteBtnClick);
            this.inviteButton.dispose();
            if (this._canUnassignPlayer) 
            {
                this.assignedList.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_DOUBLE_CLICK, this.assignedList_itemDoubleClickHandler);
                this.removeFromAssignBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleDownClick);
            }
            if (this._canAssignPlayer) 
            {
                this.unassignedList.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_DOUBLE_CLICK, this.handleMember17ItemDoubleClick);
                this.addToAssignBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleUpClick);
            }
            this.unassignedList.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.showAssignContextMenu);
            this.unassignedList.dispose();
            this.unassignedDataProvider.cleanUp();
            this.unassignedDataProvider = null;
            this.assignedList.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.showAssignContextMenu);
            this.assignedList.dispose();
            this.assignedDataProvider.cleanUp();
            this.assignedDataProvider = null;
            if (this.division.hasEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE)) 
            {
                this.division.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.handleDivisionChange);
            }
            this.division.dispose();
            if (this.isOpenCheckbox.hasEventListener(scaleform.clik.events.ButtonEvent.CLICK)) 
            {
                this.isOpenCheckbox.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleIsOpenChange);
            }
            this.isOpenCheckbox.dispose();
            App.utils.scheduler.cancelTask(this.enableReadyButton);
            App.utils.scheduler.cancelTask(this.enableChangeSettings);
            App.utils.scheduler.cancelTask(this.updateFocus);
            App.utils.scheduler.cancelTask(this.changeVisibleState);
            super.onDispose();
            return;
        }

        public function as_setComment(arg1:String):void
        {
            arg1 = org.idmedia.as3commons.util.StringUtils.trim(arg1);
            this.lastComment = arg1;
            if (!arg1) 
            {
                if (canChangeCommentS()) 
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
            var loc1:*=canChangeCommentS();
            if (arg1 == "" && !loc1) 
            {
                this.commentText.text = "";
                this.commentText.visible = false;
            }
            else if (arg1 != "") 
            {
                this.commentText.visible = true;
            }
            if (arg1 != "") 
            {
                this.isDefaultComment = false;
            }
            else 
            {
                arg1 = PREBATTLE.LABELS_COMPANY_DEFAULTCOMMENT;
                this.isDefaultComment = true;
            }
            this.commentText.text = arg1;
            this.changeAlign(this.isDefaultComment);
            if (this.commentInput && !this.isDefaultComment) 
            {
                this.commentInput.text = arg1;
                this.commentInput.enabled = loc1;
            }
            return;
        }

        public override function as_enableLeaveBtn(arg1:Boolean):void
        {
            this.updateLeaveBtn(arg1);
            return;
        }

        internal function handleOverVehicleSPGStats():void
        {
            if (this.levelSPGTooltip.length > 0) 
            {
                App.toolTipMgr.showSpecial(this.levelSPGTooltip, null);
            }
            return;
        }

        public override function as_enableReadyBtn(arg1:Boolean):void
        {
            this.enableReadyButton(arg1);
            return;
        }

        public override function as_toggleReadyBtn(arg1:Boolean):void
        {
            this.readyButton.label = arg1 ? PREBATTLE.DIALOGS_BUTTONS_READY : PREBATTLE.DIALOGS_BUTTONS_NOTREADY;
            return;
        }

        public override function as_setPlayerState(arg1:int, arg2:Boolean, arg3:Object):void
        {
            var loc5:*=null;
            var loc1:*=[];
            var loc2:*;
            var loc3:*=(loc2 = arg2 ? scaleform.clik.data.DataProvider(this.assignedList.dataProvider) : scaleform.clik.data.DataProvider(this.unassignedList.dataProvider)).length;
            var loc4:*=0;
            while (loc4 < loc3) 
            {
                if ((loc5 = loc2.requestItemAt(loc4)).uid == arg3.uid) 
                {
                    loc5.state = arg3.state;
                    loc5.vShortName = arg3.vShortName;
                    loc5.vLevel = arg3.vLevel;
                    loc5.icon = arg3.icon;
                    loc5.vType = arg3.vType;
                }
                loc1.push(loc5);
                ++loc4;
            }
            if (arg2) 
            {
                this.updateAssignList(loc1);
            }
            else 
            {
                this.updateUnassignList(loc1);
            }
            return;
        }

        public override function as_setCoolDownForReadyButton(arg1:uint):void
        {
            this.enableReadyButton(false);
            App.utils.scheduler.scheduleTask(this.enableReadyButton, arg1 * 1000, true);
            return;
        }

        public override function as_setRosterList(arg1:int, arg2:Boolean, arg3:Array):void
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc1:*=[];
            if (arg3.length > 0) 
            {
                loc2 = arg3.length;
                loc3 = 0;
                while (loc3 < loc2) 
                {
                    (loc4 = arg3[loc3] as Object)["orderNumber"] = loc3 + 1;
                    loc1.push(loc4);
                    ++loc3;
                }
            }
            if (arg2) 
            {
                this.updateAssignList(loc1);
            }
            else 
            {
                this.updateUnassignList(loc1);
            }
            this.updateMoveButtons();
            return;
        }

        public function as_setDivisionsList(arg1:Array, arg2:uint):void
        {
            if (!this.division) 
            {
                return;
            }
            this.division.dataProvider = new scaleform.clik.data.DataProvider(arg1);
            this.division.labelField = "label";
            this.autoSelectDivision(arg2);
            this.updateDivision();
            this.leaveButton.label = isPlayerCreatorS() ? MESSENGER.DIALOGS_TEAMCHANNEL_BUTTONS_DISMISS : MESSENGER.DIALOGS_TEAMCHANNEL_BUTTONS_LEAVE;
            this.updateReadyButton();
            return;
        }

        internal function updateDivision():void
        {
            this.division.enabled = this._canChangeDivision;
            return;
        }

        public var hiddenItemRenderer:net.wg.gui.prebattle.controls.TeamMemberRenderer;

        public var levelTooltip:String;

        public var upAllButton:net.wg.gui.components.controls.IconButton;

        public var downAllButton:net.wg.gui.components.controls.IconButton;

        public var limitsLabel:flash.text.TextField;

        public var channelComponent:net.wg.gui.messenger.ChannelComponent;

        public var levelSPGTooltip:String;

        public var levelTotalTooltip:String;

        public var addToAssignBtn:net.wg.gui.components.controls.IconButton;

        public var removeFromAssignBtn:net.wg.gui.components.controls.IconButton;

        public var commitEditButton:net.wg.gui.components.controls.IconButton;

        public var topBG:flash.display.MovieClip;

        public var listTitle:flash.display.MovieClip;

        public var commentInput:net.wg.gui.components.controls.TextInput;

        public var crewStuffField:flash.text.TextField;

        public var sumLevelLimitField:flash.text.TextField;

        public var queueLabel:flash.text.TextField;

        public var totalCurrentLevelField:flash.text.TextField;

        public var heavyLevelField:flash.text.TextField;

        public var mediumLevelField:flash.text.TextField;

        public var lightLevelField:flash.text.TextField;

        public var atspgLevelField:flash.text.TextField;

        public var spgLevelField:flash.text.TextField;

        public var topButtonsBG:flash.display.MovieClip;

        public var leaveButton:net.wg.gui.components.controls.SoundButtonEx;

        public var readyButton:net.wg.gui.components.controls.SoundButtonEx;

        public var inviteButton:net.wg.gui.components.controls.SoundButtonEx;

        public var division:net.wg.gui.components.controls.DropdownMenu;

        public var editButton:net.wg.gui.components.controls.IconButton;

        public var unassignedList:net.wg.gui.components.controls.ScrollingListEx;

        public var assignedList:net.wg.gui.components.controls.ScrollingListEx;

        public var unassignedDataProvider:scaleform.clik.data.DataProvider;

        public var assignedDataProvider:scaleform.clik.data.DataProvider;

        public var isOpenCheckbox:net.wg.gui.components.controls.CheckBox;

        public var _commentDefaultTextColor:uint=4473918;

        internal var _commentNormalTextColor:Number;

        internal var _canSendInvite:Boolean;

        internal var _canKickPlayer:Boolean;

        internal var _canAssignPlayer:Boolean;

        internal var _canChangeComment:Boolean;

        internal var _canMakeOpenedClosed:Boolean;

        internal var _canUnassignPlayer:Boolean=false;

        internal var _isReadyBtnEnabled:Boolean=false;

        internal var _isPlayerReady:Boolean=false;

        internal var _canChangeDivision:Boolean=false;

        internal var editState:Boolean=false;

        internal var isDefaultComment:Boolean=false;

        internal var invalidVehicles:Array;

        internal var _isPlayerCreator:Boolean=false;

        internal var lastComment:String="";

        internal var buttonsUpdated:Boolean=false;

        public var commentText:flash.text.TextField;

        internal var _isLeaveBtnEnabled:Boolean=false;
    }
}
