package net.wg.gui.prebattle.battleSession 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.data.*;
    import net.wg.data.components.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.messengerBar.*;
    import net.wg.gui.messenger.*;
    import net.wg.gui.prebattle.controls.*;
    import net.wg.gui.prebattle.data.*;
    import net.wg.gui.prebattle.meta.*;
    import net.wg.gui.prebattle.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import scaleform.clik.utils.*;
    import scaleform.gfx.*;
    
    public class BattleSessionWindow extends net.wg.gui.prebattle.meta.impl.BattleSessionWindowMeta implements net.wg.gui.prebattle.meta.IBattleSessionWindowMeta
    {
        public function BattleSessionWindow()
        {
            super();
            this._canKickPlayer = false;
            this._isReady = false;
            showWindowBg = false;
            canResize = true;
            canMinimize = true;
            enabledCloseBtn = false;
            isCentered = false;
            return;
        }

        public function as_setClassesLimits(arg1:Object, arg2:Boolean):void
        {
            var loc1:*=null;
            if (arg2) 
            {
                this.requirementInfo.requiredTypeText.visible = true;
                this.requirementInfo.icons.visible = false;
                this.requirementInfo.requiredTypeText.text = MENU.CLASSES_ANYTYPE;
            }
            else 
            {
                this.requirementInfo.requiredTypeText.visible = false;
                this.requirementInfo.icons.visible = true;
            }
            var loc2:*=0;
            var loc3:*=arg1;
            for (loc1 in loc3) 
            {
                this.requirementInfo.textFields[loc1].text = arg1[loc1];
            }
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                _width = window.width - window.contentPadding.left - window.contentPadding.right;
                _height = window.height - window.contentPadding.top - window.contentPadding.bottom;
                constraints.update(_width, _height);
                this.topInfo.x = Math.round(_width / 2);
                this.requirementInfo.x = Math.round(_width / 2);
            }
            if (isInvalid(INVALIDATE_TEAMS)) 
            {
                this.redrawList();
            }
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

        protected override function onPopulate():void
        {
            super.onPopulate();
            registerComponent(this.channelComponent, net.wg.data.Aliases.CHANNEL_COMPONENT);
            this._isReady = isPlayerReadyS();
            this.readyButton.label = this._isReady ? PREBATTLE.DIALOGS_BUTTONS_NOTREADY : PREBATTLE.DIALOGS_BUTTONS_READY;
            this.readyButton.enabled = isReadyBtnEnabledS();
            this.leaveButton.enabled = isLeaveBtnEnabledS();
            this._canKickPlayer = canKickPlayerS();
            window.setTitleIcon("team");
            geometry = new net.wg.gui.lobby.messengerBar.WindowGeometryInBar(net.wg.gui.events.MessengerBarEvent.PIN_CAROUSEL_WINDOW, getClientIDS());
            return;
        }

        public override function as_refreshPermissions():void
        {
            this._isReady = isPlayerReadyS();
            this.readyButton.label = this._isReady ? PREBATTLE.DIALOGS_BUTTONS_NOTREADY : PREBATTLE.DIALOGS_BUTTONS_READY;
            this.readyButton.enabled = isReadyBtnEnabledS();
            this.leaveButton.enabled = isLeaveBtnEnabledS();
            this._canKickPlayer = canKickPlayerS();
            this.downButton.enabled = canMoveToUnassignedS() && this.memberList.dataProvider.length > 0;
            this.upButton.enabled = canMoveToAssignedS() && this.memberStackList.dataProvider.length > 0;
            return;
        }

        public override function as_setRosterList(arg1:int, arg2:Boolean, arg3:Array):void
        {
            this.firstLength = arg2 ? arg3.length : this.firstLength;
            var loc1:*=0;
            while (loc1 < arg3.length) 
            {
                arg3[loc1].orderNumber = arg2 ? loc1 + 1 : this.firstLength + loc1 + 1;
                ++loc1;
            }
            if (arg2) 
            {
                this.memberList.dataProvider = new scaleform.clik.data.DataProvider(arg3);
            }
            else 
            {
                this.memberStackList.dataProvider = new scaleform.clik.data.DataProvider(arg3);
            }
            invalidate(INVALIDATE_TEAMS);
            return;
        }

        public function as_setInfo(arg1:String, arg2:String, arg3:String, arg4:String, arg5:String, arg6:String, arg7:String):void
        {
            this.winsValue.text = arg1;
            this.mapValue.text = arg2;
            this.topInfo.firstTeamText.text = arg3;
            this.topInfo.secondTeamText.text = arg4;
            this.topInfo.winTeamsText.text = arg5;
            window.title = arg6;
            this.commentValue.text = arg7;
            return;
        }

        public function as_setCommonLimits(arg1:Number, arg2:Number, arg3:Number, arg4:Number):void
        {
            if (arg2 <= arg1 && arg1 <= arg3) 
            {
                this.topStats.valueTF.text = String(arg1);
            }
            else 
            {
                this.topStats.valueTF.htmlText = "<font color=\"#ff0000\">" + arg1 + "</font>";
            }
            this._maxPlayers = arg4;
            invalidate(INVALIDATE_TEAMS);
            return;
        }

        public function as_setNationsLimits(arg1:Array):void
        {
            if (arg1) 
            {
                this.requirementInfo.flagList.visible = true;
                this.requirementInfo.requiredNationText.visible = false;
                this.requirementInfo.flagList.dataProvider = new scaleform.clik.data.DataProvider(arg1);
            }
            else 
            {
                this.requirementInfo.flagList.visible = false;
                this.requirementInfo.requiredNationText.visible = true;
                this.requirementInfo.flagList.dataProvider = new scaleform.clik.data.DataProvider(arg1);
                this.requirementInfo.requiredNationText.text = MENU.NATIONS_ALL;
            }
            return;
        }

        public override function as_enableLeaveBtn(arg1:Boolean):void
        {
            this.leaveButton.enabled = arg1;
            return;
        }

        public override function as_enableReadyBtn(arg1:Boolean):void
        {
            this.readyButton.enabled = arg1;
            return;
        }

        public override function as_setPlayerState(arg1:int, arg2:Boolean, arg3:Object):void
        {
            if (arg2) 
            {
                checkStatus(this.memberList, arg3);
            }
            else 
            {
                checkStatus(this.memberStackList, arg3);
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.hiddenRenderer.visible = false;
            this.hiddenRenderer.data = null;
            this.setConstraints();
            this.setControlsLabels();
            this.memberList.addEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.showContextMenu);
            this.memberList.addEventListener(net.wg.gui.events.ListEventEx.ITEM_DOUBLE_CLICK, this.handleDoubleClick);
            this.memberList.labelField = "fullName";
            this.memberList.useRightButton = true;
            this.memberStackList.addEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.showContextMenu);
            this.memberStackList.addEventListener(net.wg.gui.events.ListEventEx.ITEM_DOUBLE_CLICK, this.handleDoubleClick);
            this.memberStackList.useRightButton = true;
            this.memberStackList.labelField = "fullName";
            this.upButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleUpClick);
            this.downButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleDownClick);
            this.readyButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleReadyClick);
            this.leaveButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleLeaveClick);
            this.commentValue.autoScroll = true;
            this.commentValue.selectable = true;
            this.commentValue.textField.selectable = true;
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.memberList.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.showContextMenu);
            this.memberStackList.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.showContextMenu);
            this.upButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleUpClick);
            this.downButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleDownClick);
            this.readyButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleReadyClick);
            this.leaveButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleLeaveClick);
            return;
        }

        internal function showContextMenu(arg1:net.wg.gui.events.ListEventEx):void
        {
            var loc1:*=null;
            var loc2:*=false;
            var loc3:*=null;
            this._canKickPlayer = canKickPlayerS();
            if (arg1.buttonIdx == scaleform.gfx.MouseEventEx.RIGHT_BUTTON) 
            {
                loc1 = new net.wg.gui.prebattle.data.PlayerPrbInfoVO(arg1.itemData);
                if (loc1.accID > -1) 
                {
                    loc2 = loc1.uid > -1;
                    loc3 = new net.wg.data.components.BattleSessionCIGenerator(loc2, this._canKickPlayer);
                    App.contextMenuMgr.showUserContextMenu(this, loc1, loc3);
                }
                else 
                {
                    App.contextMenuMgr.hide();
                }
            }
            return;
        }

        internal function handleReadyClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            requestToReadyS(!this._isReady);
            return;
        }

        public override function as_setCoolDownForReadyButton(arg1:uint):void
        {
            App.utils.scheduler.cancelTask(this.stopReadyButtonCoolDown);
            this.readyButton.enabled = false;
            App.utils.scheduler.scheduleTask(this.stopReadyButtonCoolDown, arg1 * 1000);
            return;
        }

        internal function stopReadyButtonCoolDown():void
        {
            this.readyButton.enabled = true;
            return;
        }

        public override function as_toggleReadyBtn(arg1:Boolean):void
        {
            this._isReady = !arg1;
            this.readyButton.label = this._isReady ? PREBATTLE.DIALOGS_BUTTONS_NOTREADY : PREBATTLE.DIALOGS_BUTTONS_READY;
            return;
        }

        internal function handleLeaveClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            requestToLeaveS();
            return;
        }

        internal function handleUpClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            var loc1:*=null;
            if (this.memberStackList.dataProvider.length > 0) 
            {
                if (this.memberStackList.selectedIndex > -1) 
                {
                    loc1 = new net.wg.gui.prebattle.data.PlayerPrbInfoVO(this.memberStackList.dataProvider.requestItemAt(this.memberStackList.selectedIndex));
                    requestToAssignMemberS(loc1.accID);
                }
            }
            return;
        }

        internal function handleDoubleClick(arg1:net.wg.gui.events.ListEventEx):void
        {
            if (arg1.target == this.memberList) 
            {
                if (canMoveToUnassignedS()) 
                {
                    requestToUnassignMemberS(arg1.itemData.accID);
                }
            }
            if (arg1.target == this.memberStackList) 
            {
                if (canMoveToAssignedS()) 
                {
                    requestToAssignMemberS(arg1.itemData.accID);
                }
            }
            return;
        }

        internal function handleDownClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            var loc1:*=null;
            if (this.memberList.dataProvider.length > 0) 
            {
                if (this.memberList.selectedIndex > -1) 
                {
                    loc1 = new net.wg.gui.prebattle.data.PlayerPrbInfoVO(this.memberList.dataProvider.requestItemAt(this.memberList.selectedIndex));
                    requestToUnassignMemberS(loc1.accID);
                }
            }
            return;
        }

        internal function redrawList():void
        {
            var loc1:*=this.firstLength >= 5 ? this.firstLength : 5;
            this.memberList.height = 20 * loc1 + 2;
            var loc2:*=this.memberList.y + this.memberList.height + 5;
            this.upAllButton.y = loc2;
            this.upButton.y = loc2;
            this.downButton.y = loc2;
            this.downAllButton.y = loc2;
            this.memberStackList.y = loc2 + 24;
            this.memberStackList.height = 20 * (19 - loc1) + 2;
            this.downButton.enabled = canMoveToUnassignedS() && this.memberList.dataProvider.length > 0;
            this.upButton.enabled = canMoveToAssignedS() && this.memberStackList.dataProvider.length > 0;
            if (this.firstLength < this._maxPlayers) 
            {
                this.playersStats.valueTF.text = this.firstLength + "/" + this._maxPlayers;
            }
            else 
            {
                this.playersStats.valueTF.htmlText = "<font color=\"#ff0000\">" + this.firstLength + "/" + this._maxPlayers + "</font>";
            }
            return;
        }

        internal function setConstraints():void
        {
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.REFLOW);
            constraints.addElement("upButton", this.upButton, scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("upAllButton", this.upAllButton, scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("downButton", this.downButton, scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("downAllButton", this.downAllButton, scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("topBG", this.topBG, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("topStats", this.topStats, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("listTitle", this.listTitle, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("mapValue", this.mapValue, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("winsText", this.winsText, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("winsValue", this.winsValue, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("topHeaderBG", this.topHeaderBG, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("leaveButton", this.leaveButton, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("readyButton", this.readyButton, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("memberList", this.memberList, scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("messageArea", this.channelComponent.messageArea, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("commentValue", this.commentValue, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("messageInput", this.channelComponent.messageInput, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("sendButton", this.channelComponent.sendButton, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("memberStackList", this.memberStackList, scaleform.clik.utils.Constraints.RIGHT);
            return;
        }

        internal function setControlsLabels():void
        {
            this.topStats.titleTF.text = PREBATTLE.LABELS_STATS_LEVEL;
            this.playersStats.titleTF.text = PREBATTLE.LABELS_STATS_MAXPLAYERS;
            this.listTitle.player.text = PREBATTLE.LABELS_PLAYER;
            this.listTitle.vehicle.text = PREBATTLE.LABELS_VEHICLE;
            this.listTitle.level.text = PREBATTLE.LABELS_LEVEL;
            this.topInfo.startTimeText.text = PREBATTLE.TITLE_BATTLESESSION_HEADER_STARTTIME;
            this.commentText.text = PREBATTLE.TITLE_BATTLESESSION_COMMENT;
            this.mapText.text = PREBATTLE.TITLE_BATTLESESSION_ARENATYPE;
            this.winsText.text = PREBATTLE.TITLE_BATTLESESSION_BATTLESLIMIT;
            this.vehicleLevelText.text = PREBATTLE.STATS_BATTLESESSION_COMMONLEVEL;
            this.requiredText.text = PREBATTLE.STATS_BATTLESESSION_REQUIRED;
            this.vehicleTypeText.text = PREBATTLE.STATS_BATTLESESSION_VEHICLETYPE;
            this.leaveButton.label = PREBATTLE.BUTTONS_BATTLESESSION_LEAVE;
            return;
        }

        internal function onTimerChange(arg1:flash.events.TimerEvent):void
        {
            this.setTimeValue();
            return;
        }

        internal function setTimeValue():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            if (this._startTime >= 0) 
            {
                loc1 = Math.floor(this._startTime / 3600);
                loc2 = Math.floor(this._startTime % 3600 / 60);
                loc3 = Math.floor(this._startTime % 3600 % 60);
                --this._startTime;
                this.topInfo.startTimeValue.text = (loc1 != 0 ? loc1 < 10 ? "0" + loc1.toString() + ":" : loc1.toString() + ":" : "") + (loc2 < 10 ? "0" + loc2.toString() : loc2.toString()) + ":" + (loc3 < 10 ? "0" + loc3.toString() : loc3.toString());
            }
            else if (this.timer) 
            {
                this.timer.stop();
                this.timer.removeEventListener(flash.events.TimerEvent.TIMER, this.onTimerChange);
                this.timer = null;
            }
            return;
        }

        public function as_setStartTime(arg1:Number):void
        {
            this._startTime = arg1;
            if (this.timer) 
            {
                this.timer.stop();
                this.timer.removeEventListener(flash.events.TimerEvent.TIMER, this.onTimerChange);
                this.timer = null;
            }
            this.timer = new flash.utils.Timer(1000, 0);
            this.timer.addEventListener(flash.events.TimerEvent.TIMER, this.onTimerChange);
            this.timer.start();
            this.setTimeValue();
            return;
        }

        internal static function checkStatus(arg1:scaleform.clik.controls.CoreList, arg2:Object):void
        {
            var loc3:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc1:*=new net.wg.gui.prebattle.data.PlayerPrbInfoVO(arg2);
            var loc2:*=arg1.dataProvider.length;
            var loc4:*=arg1.dataProvider;
            var loc5:*=0;
            while (loc5 < loc2) 
            {
                if ((loc6 = loc4.requestItemAt(loc5)).uid == loc1.uid) 
                {
                    var loc8:*=0;
                    var loc9:*=arg2;
                    for (loc7 in loc9) 
                    {
                        if (!loc6.hasOwnProperty(loc7)) 
                        {
                            continue;
                        }
                        loc6[loc7] = arg2[loc7];
                    }
                    arg1.invalidateData();
                }
                ++loc5;
            }
            return;
        }

        internal static const INVALIDATE_TEAMS:String="InvalidateTeams";

        public var downAllButton:net.wg.gui.components.controls.IconButton;

        internal var _canKickPlayer:Boolean;

        internal var _isReady:Boolean;

        internal var _startTime:Number=-1;

        public var channelComponent:net.wg.gui.messenger.ChannelComponent;

        public var upAllButton:net.wg.gui.components.controls.IconButton;

        public var upButton:net.wg.gui.components.controls.IconButton;

        public var downButton:net.wg.gui.components.controls.IconButton;

        internal var firstLength:Number=0;

        public var topBG:flash.display.MovieClip;

        public var topStats:net.wg.gui.prebattle.battleSession.TopStats;

        public var playersStats:net.wg.gui.prebattle.battleSession.TopStats;

        public var listTitle:flash.display.MovieClip;

        public var commentText:flash.text.TextField;

        public var winsText:flash.text.TextField;

        public var winsValue:flash.text.TextField;

        public var mapText:flash.text.TextField;

        public var mapValue:flash.text.TextField;

        public var topHeaderBG:flash.display.MovieClip;

        public var topInfo:flash.display.MovieClip;

        public var hiddenRenderer:net.wg.gui.prebattle.controls.TeamMemberRenderer;

        public var memberStackList:net.wg.gui.components.controls.ScrollingListEx;

        public var memberList:net.wg.gui.components.controls.ScrollingListEx;

        public var readyButton:net.wg.gui.components.controls.SoundButtonEx;

        public var leaveButton:net.wg.gui.components.controls.SoundButtonEx;

        internal var timer:flash.utils.Timer=null;

        public var requirementInfo:net.wg.gui.prebattle.battleSession.RequirementInfo;

        public var requiredText:flash.text.TextField;

        public var vehicleTypeText:flash.text.TextField;

        public var vehicleLevelText:flash.text.TextField;

        public var commentValue:net.wg.gui.components.advanced.TextAreaSimple;

        internal var _maxPlayers:Number;
    }
}
