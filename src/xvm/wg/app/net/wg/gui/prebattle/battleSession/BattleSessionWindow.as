package net.wg.gui.prebattle.battleSession
{
    import net.wg.gui.prebattle.meta.impl.BattleSessionWindowMeta;
    import net.wg.gui.prebattle.meta.IBattleSessionWindowMeta;
    import scaleform.clik.controls.CoreList;
    import scaleform.clik.interfaces.IListItemRenderer;
    import net.wg.gui.prebattle.data.PlayerPrbInfoVO;
    import scaleform.clik.interfaces.IDataProvider;
    import net.wg.gui.components.controls.IconButton;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.gui.prebattle.controls.TeamMemberRenderer;
    import net.wg.gui.components.controls.ScrollingListEx;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.advanced.TextAreaSimple;
    import flash.utils.Timer;
    import scaleform.clik.data.DataProvider;
    import flash.events.TimerEvent;
    import net.wg.data.Aliases;
    import net.wg.gui.lobby.messengerBar.WindowGeometryInBar;
    import net.wg.gui.events.MessengerBarEvent;
    import net.wg.gui.events.ListEventEx;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.utils.Constraints;
    import scaleform.clik.constants.ConstrainMode;
    import net.wg.infrastructure.interfaces.IUserContextMenuGenerator;
    import scaleform.gfx.MouseEventEx;
    import net.wg.data.components.BattleSessionCIGenerator;
    
    public class BattleSessionWindow extends BattleSessionWindowMeta implements IBattleSessionWindowMeta
    {
        
        public function BattleSessionWindow() {
            super();
            this._canKickPlayer = false;
            this._isReady = false;
            showWindowBg = false;
            canResize = true;
            canMinimize = true;
            enabledCloseBtn = false;
            isCentered = false;
        }
        
        private static var INVALIDATE_TEAMS:String = "InvalidateTeams";
        
        private static function checkStatus(param1:CoreList, param2:Object) : void {
            var _loc5_:IListItemRenderer = null;
            var _loc8_:Object = null;
            var _loc9_:String = null;
            var _loc3_:PlayerPrbInfoVO = new PlayerPrbInfoVO(param2);
            var _loc4_:int = param1.dataProvider.length;
            var _loc6_:IDataProvider = param1.dataProvider;
            var _loc7_:* = 0;
            while(_loc7_ < _loc4_)
            {
                _loc8_ = _loc6_.requestItemAt(_loc7_);
                if(_loc8_.dbID == _loc3_.dbID)
                {
                    for(_loc9_ in param2)
                    {
                        if(_loc8_.hasOwnProperty(_loc9_))
                        {
                            _loc8_[_loc9_] = param2[_loc9_];
                        }
                    }
                    param1.invalidateData();
                }
                _loc7_++;
            }
        }
        
        public var upAllButton:IconButton;
        
        public var upButton:IconButton;
        
        public var downButton:IconButton;
        
        public var downAllButton:IconButton;
        
        public var topBG:MovieClip;
        
        public var topStats:TopStats;
        
        public var playersStats:TopStats;
        
        public var listTitle:MovieClip;
        
        public var commentText:TextField;
        
        public var winsText:TextField;
        
        public var winsValue:TextField;
        
        public var mapText:TextField;
        
        public var mapValue:TextField;
        
        public var topHeaderBG:MovieClip;
        
        public var topInfo:MovieClip;
        
        public var hiddenRenderer:TeamMemberRenderer;
        
        public var memberStackList:ScrollingListEx;
        
        public var memberList:ScrollingListEx;
        
        public var leaveButton:SoundButtonEx;
        
        public var readyButton:SoundButtonEx;
        
        public var requirementInfo:RequirementInfo;
        
        public var requiredText:TextField;
        
        public var vehicleTypeText:TextField;
        
        public var vehicleLevelText:TextField;
        
        public var commentValue:TextAreaSimple;
        
        private var _canKickPlayer:Boolean;
        
        private var _isReady:Boolean;
        
        private var _startTime:Number = -1;
        
        private var timer:Timer = null;
        
        private var _maxPlayers:Number;
        
        private var firstLength:Number = 0;
        
        override public function as_refreshPermissions() : void {
            this._isReady = isPlayerReadyS();
            this.readyButton.label = this._isReady?PREBATTLE.DIALOGS_BUTTONS_NOTREADY:PREBATTLE.DIALOGS_BUTTONS_READY;
            this.readyButton.enabled = isReadyBtnEnabledS();
            this.leaveButton.enabled = isLeaveBtnEnabledS();
            this._canKickPlayer = canKickPlayerS();
            this.downButton.enabled = (canMoveToUnassignedS()) && this.memberList.dataProvider.length > 0;
            this.upButton.enabled = (canMoveToAssignedS()) && this.memberStackList.dataProvider.length > 0;
        }
        
        override public function as_setRosterList(param1:int, param2:Boolean, param3:Array) : void {
            this.firstLength = param2?param3.length:this.firstLength;
            var _loc4_:* = 0;
            while(_loc4_ < param3.length)
            {
                param3[_loc4_].orderNumber = param2?_loc4_ + 1:this.firstLength + _loc4_ + 1;
                _loc4_++;
            }
            if(param2)
            {
                this.memberList.dataProvider = new DataProvider(param3);
            }
            else
            {
                this.memberStackList.dataProvider = new DataProvider(param3);
            }
            invalidate(INVALIDATE_TEAMS);
        }
        
        override public function as_enableLeaveBtn(param1:Boolean) : void {
            this.leaveButton.enabled = param1;
        }
        
        override public function as_enableReadyBtn(param1:Boolean) : void {
            this.readyButton.enabled = param1;
        }
        
        override public function as_setPlayerState(param1:int, param2:Boolean, param3:Object) : void {
            if(param2)
            {
                checkStatus(this.memberList,param3);
            }
            else
            {
                checkStatus(this.memberStackList,param3);
            }
        }
        
        override public function as_setCoolDownForReadyButton(param1:uint) : void {
            App.utils.scheduler.cancelTask(this.stopReadyButtonCoolDown);
            this.readyButton.enabled = false;
            App.utils.scheduler.scheduleTask(this.stopReadyButtonCoolDown,param1 * 1000);
        }
        
        override public function as_toggleReadyBtn(param1:Boolean) : void {
            this._isReady = !param1;
            this.readyButton.label = this._isReady?PREBATTLE.DIALOGS_BUTTONS_NOTREADY:PREBATTLE.DIALOGS_BUTTONS_READY;
        }
        
        public function as_setInfo(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String) : void {
            this.winsValue.text = param1;
            this.mapValue.text = param2;
            this.topInfo.firstTeamText.text = param3;
            this.topInfo.secondTeamText.text = param4;
            this.topInfo.winTeamsText.text = param5;
            window.title = param6;
            this.commentValue.text = param7;
        }
        
        public function as_setCommonLimits(param1:Number, param2:Number, param3:Number, param4:Number) : void {
            if(param2 <= param1 && param1 <= param3)
            {
                this.topStats.valueTF.text = String(param1);
            }
            else
            {
                this.topStats.valueTF.htmlText = "<font color=\"#ff0000\">" + param1 + "</font>";
            }
            this._maxPlayers = param4;
            invalidate(INVALIDATE_TEAMS);
        }
        
        public function as_setNationsLimits(param1:Array) : void {
            if(param1)
            {
                this.requirementInfo.flagList.visible = true;
                this.requirementInfo.requiredNationText.visible = false;
                this.requirementInfo.flagList.dataProvider = new DataProvider(param1);
            }
            else
            {
                this.requirementInfo.flagList.visible = false;
                this.requirementInfo.requiredNationText.visible = true;
                this.requirementInfo.flagList.dataProvider = new DataProvider(param1);
                this.requirementInfo.requiredNationText.text = MENU.NATIONS_ALL;
            }
        }
        
        public function as_setClassesLimits(param1:Object, param2:Boolean) : void {
            var _loc3_:String = null;
            if(param2)
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
            for(_loc3_ in param1)
            {
                this.requirementInfo.textFields[_loc3_].text = param1[_loc3_];
            }
        }
        
        public function as_setStartTime(param1:Number) : void {
            this._startTime = param1;
            if(this.timer)
            {
                this.timer.stop();
                this.timer.removeEventListener(TimerEvent.TIMER,this.onTimerChange);
                this.timer = null;
            }
            this.timer = new Timer(1000,0);
            this.timer.addEventListener(TimerEvent.TIMER,this.onTimerChange);
            this.timer.start();
            this.setTimeValue();
        }
        
        override protected function onPopulate() : void {
            super.onPopulate();
            registerComponent(channelComponent,Aliases.CHANNEL_COMPONENT);
            this._isReady = isPlayerReadyS();
            this.readyButton.label = this._isReady?PREBATTLE.DIALOGS_BUTTONS_NOTREADY:PREBATTLE.DIALOGS_BUTTONS_READY;
            this.readyButton.enabled = isReadyBtnEnabledS();
            this.leaveButton.enabled = isLeaveBtnEnabledS();
            this._canKickPlayer = canKickPlayerS();
            window.setTitleIcon("team");
            geometry = new WindowGeometryInBar(MessengerBarEvent.PIN_CAROUSEL_WINDOW,getClientIDS());
        }
        
        override protected function configUI() : void {
            super.configUI();
            this.hiddenRenderer.visible = false;
            this.hiddenRenderer.data = null;
            this.setConstraints();
            this.setControlsLabels();
            this.memberList.addEventListener(ListEventEx.ITEM_CLICK,this.showContextMenu);
            this.memberList.addEventListener(ListEventEx.ITEM_DOUBLE_CLICK,this.handleDoubleClick);
            this.memberList.labelField = "fullName";
            this.memberList.useRightButton = true;
            this.memberStackList.addEventListener(ListEventEx.ITEM_CLICK,this.showContextMenu);
            this.memberStackList.addEventListener(ListEventEx.ITEM_DOUBLE_CLICK,this.handleDoubleClick);
            this.memberStackList.useRightButton = true;
            this.memberStackList.labelField = "fullName";
            this.upButton.addEventListener(ButtonEvent.CLICK,this.handleUpClick);
            this.downButton.addEventListener(ButtonEvent.CLICK,this.handleDownClick);
            this.readyButton.addEventListener(ButtonEvent.CLICK,this.handleReadyClick);
            this.leaveButton.addEventListener(ButtonEvent.CLICK,this.handleLeaveClick);
            this.commentValue.autoScroll = true;
            this.commentValue.selectable = true;
            this.commentValue.textField.selectable = true;
        }
        
        override protected function onDispose() : void {
            super.onDispose();
            this.memberList.removeEventListener(ListEventEx.ITEM_CLICK,this.showContextMenu);
            this.memberStackList.removeEventListener(ListEventEx.ITEM_CLICK,this.showContextMenu);
            this.upButton.removeEventListener(ButtonEvent.CLICK,this.handleUpClick);
            this.downButton.removeEventListener(ButtonEvent.CLICK,this.handleDownClick);
            this.readyButton.removeEventListener(ButtonEvent.CLICK,this.handleReadyClick);
            this.leaveButton.removeEventListener(ButtonEvent.CLICK,this.handleLeaveClick);
        }
        
        override protected function draw() : void {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                _width = window.width - window.contentPadding.left - window.contentPadding.right;
                _height = window.height - window.contentPadding.top - window.contentPadding.bottom;
                constraints.update(_width,_height);
                this.topInfo.x = Math.round(_width / 2);
                this.requirementInfo.x = Math.round(_width / 2);
            }
            if(isInvalid(INVALIDATE_TEAMS))
            {
                this.redrawList();
            }
        }
        
        private function stopReadyButtonCoolDown() : void {
            this.readyButton.enabled = true;
        }
        
        private function redrawList() : void {
            var _loc1_:Number = this.firstLength >= 5?this.firstLength:5;
            this.memberList.height = 20 * _loc1_ + 2;
            var _loc2_:Number = this.memberList.y + this.memberList.height + 5;
            this.upAllButton.y = _loc2_;
            this.upButton.y = _loc2_;
            this.downButton.y = _loc2_;
            this.downAllButton.y = _loc2_;
            this.memberStackList.y = _loc2_ + 24;
            this.memberStackList.height = 20 * (19 - _loc1_) + 2;
            this.downButton.enabled = (canMoveToUnassignedS()) && this.memberList.dataProvider.length > 0;
            this.upButton.enabled = (canMoveToAssignedS()) && this.memberStackList.dataProvider.length > 0;
            if(this.firstLength < this._maxPlayers)
            {
                this.playersStats.valueTF.text = this.firstLength + "/" + this._maxPlayers;
            }
            else
            {
                this.playersStats.valueTF.htmlText = "<font color=\"#ff0000\">" + this.firstLength + "/" + this._maxPlayers + "</font>";
            }
        }
        
        private function setConstraints() : void {
            constraints = new Constraints(this,ConstrainMode.REFLOW);
            constraints.addElement("upButton",this.upButton,Constraints.RIGHT);
            constraints.addElement("upAllButton",this.upAllButton,Constraints.RIGHT);
            constraints.addElement("downButton",this.downButton,Constraints.RIGHT);
            constraints.addElement("downAllButton",this.downAllButton,Constraints.RIGHT);
            constraints.addElement("topBG",this.topBG,Constraints.TOP | Constraints.LEFT | Constraints.RIGHT);
            constraints.addElement("topStats",this.topStats,Constraints.TOP | Constraints.RIGHT);
            constraints.addElement("listTitle",this.listTitle,Constraints.TOP | Constraints.RIGHT);
            constraints.addElement("mapValue",this.mapValue,Constraints.TOP | Constraints.LEFT | Constraints.RIGHT);
            constraints.addElement("winsText",this.winsText,Constraints.TOP | Constraints.RIGHT);
            constraints.addElement("winsValue",this.winsValue,Constraints.TOP | Constraints.RIGHT);
            constraints.addElement("topHeaderBG",this.topHeaderBG,Constraints.TOP | Constraints.LEFT | Constraints.RIGHT);
            constraints.addElement("leaveButton",this.leaveButton,Constraints.TOP | Constraints.LEFT | Constraints.RIGHT);
            constraints.addElement("readyButton",this.readyButton,Constraints.TOP | Constraints.RIGHT);
            constraints.addElement("memberList",this.memberList,Constraints.RIGHT);
            constraints.addElement("messageArea",channelComponent.messageArea,Constraints.TOP | Constraints.LEFT | Constraints.RIGHT);
            constraints.addElement("commentValue",this.commentValue,Constraints.TOP | Constraints.LEFT | Constraints.RIGHT);
            constraints.addElement("messageInput",channelComponent.messageInput,Constraints.TOP | Constraints.LEFT | Constraints.RIGHT);
            constraints.addElement("sendButton",channelComponent.sendButton,Constraints.TOP | Constraints.RIGHT);
            constraints.addElement("memberStackList",this.memberStackList,Constraints.RIGHT);
        }
        
        private function setControlsLabels() : void {
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
        }
        
        private function setTimeValue() : void {
            var _loc1_:* = NaN;
            var _loc2_:* = NaN;
            var _loc3_:* = NaN;
            if(this._startTime >= 0)
            {
                _loc1_ = Math.floor(this._startTime / 3600);
                _loc2_ = Math.floor(this._startTime % 3600 / 60);
                _loc3_ = Math.floor(this._startTime % 3600 % 60);
                this._startTime = this._startTime - 1;
                this.topInfo.startTimeValue.text = (_loc1_ == 0?"":_loc1_ < 10?"0" + _loc1_.toString() + ":":_loc1_.toString() + ":") + (_loc2_ < 10?"0" + _loc2_.toString():_loc2_.toString()) + ":" + (_loc3_ < 10?"0" + _loc3_.toString():_loc3_.toString());
            }
            else if(this.timer)
            {
                this.timer.stop();
                this.timer.removeEventListener(TimerEvent.TIMER,this.onTimerChange);
                this.timer = null;
            }
            
        }
        
        private function showContextMenu(param1:ListEventEx) : void {
            var _loc2_:PlayerPrbInfoVO = null;
            var _loc3_:* = false;
            var _loc4_:IUserContextMenuGenerator = null;
            this._canKickPlayer = canKickPlayerS();
            if(param1.buttonIdx == MouseEventEx.RIGHT_BUTTON)
            {
                _loc2_ = new PlayerPrbInfoVO(param1.itemData);
                if(_loc2_.accID > -1)
                {
                    _loc3_ = _loc2_.dbID > -1;
                    _loc4_ = new BattleSessionCIGenerator(_loc3_,this._canKickPlayer);
                    App.contextMenuMgr.showUserContextMenu(this,_loc2_,_loc4_);
                }
                else
                {
                    App.contextMenuMgr.hide();
                }
            }
        }
        
        private function handleReadyClick(param1:ButtonEvent) : void {
            requestToReadyS(!this._isReady);
        }
        
        private function handleLeaveClick(param1:ButtonEvent) : void {
            requestToLeaveS();
        }
        
        private function handleUpClick(param1:ButtonEvent) : void {
            var _loc2_:PlayerPrbInfoVO = null;
            if(this.memberStackList.dataProvider.length > 0)
            {
                if(this.memberStackList.selectedIndex > -1)
                {
                    _loc2_ = new PlayerPrbInfoVO(this.memberStackList.dataProvider.requestItemAt(this.memberStackList.selectedIndex));
                    requestToAssignMemberS(_loc2_.accID);
                }
            }
        }
        
        private function handleDoubleClick(param1:ListEventEx) : void {
            if(param1.target == this.memberList)
            {
                if(canMoveToUnassignedS())
                {
                    requestToUnassignMemberS(param1.itemData.accID);
                }
            }
            if(param1.target == this.memberStackList)
            {
                if(canMoveToAssignedS())
                {
                    requestToAssignMemberS(param1.itemData.accID);
                }
            }
        }
        
        private function handleDownClick(param1:ButtonEvent) : void {
            var _loc2_:PlayerPrbInfoVO = null;
            if(this.memberList.dataProvider.length > 0)
            {
                if(this.memberList.selectedIndex > -1)
                {
                    _loc2_ = new PlayerPrbInfoVO(this.memberList.dataProvider.requestItemAt(this.memberList.selectedIndex));
                    requestToUnassignMemberS(_loc2_.accID);
                }
            }
        }
        
        private function onTimerChange(param1:TimerEvent) : void {
            this.setTimeValue();
        }
    }
}
