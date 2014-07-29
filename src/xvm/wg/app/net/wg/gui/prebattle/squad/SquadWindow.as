package net.wg.gui.prebattle.squad
{
    import net.wg.gui.prebattle.meta.abstract.PrebattleWindowAbstract;
    import net.wg.gui.prebattle.meta.IPrebattleWindowMeta;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.controls.ScrollingListEx;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.prebattle.data.PlayerPrbInfoVO;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.utils.Constraints;
    import scaleform.clik.constants.ConstrainMode;
    import net.wg.gui.events.ListEventEx;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.components.windows.Window;
    import net.wg.data.Aliases;
    import scaleform.clik.utils.Padding;
    import net.wg.gui.lobby.messengerBar.WindowGeometryInBar;
    import net.wg.gui.events.MessengerBarEvent;
    import flash.utils.setTimeout;
    import flash.utils.clearTimeout;
    import net.wg.infrastructure.interfaces.IUserContextMenuGenerator;
    import scaleform.gfx.MouseEventEx;
    
    public class SquadWindow extends PrebattleWindowAbstract implements IPrebattleWindowMeta
    {
        
        public function SquadWindow()
        {
            super();
        }
        
        public var leaveButton:SoundButtonEx;
        
        public var readyButton:SoundButtonEx;
        
        public var memberList:ScrollingListEx;
        
        private var readyBtnCoolDownID:uint = 0;
        
        private var memberDataProvider:DataProvider;
        
        private var _isReadyBtnEnabled:Boolean = false;
        
        private var _isLeaveBtnEnabled:Boolean = false;
        
        private var _canSendInvites:Boolean = false;
        
        override public function as_enableLeaveBtn(param1:Boolean) : void
        {
            this.leaveButton.enabled = param1;
        }
        
        override public function as_enableReadyBtn(param1:Boolean) : void
        {
            this.readyButton.enabled = param1;
        }
        
        override public function as_toggleReadyBtn(param1:Boolean) : void
        {
            this.readyButton.label = param1?MESSENGER.DIALOGS_SQUADCHANNEL_BUTTONS_READY:MESSENGER.DIALOGS_SQUADCHANNEL_BUTTONS_NOTREADY;
        }
        
        override public function as_setPlayerState(param1:int, param2:Boolean, param3:Object) : void
        {
            var _loc4_:PlayerPrbInfoVO = null;
            var _loc6_:PlayerPrbInfoVO = null;
            var _loc7_:SquadItemRenderer = null;
            if(param3)
            {
                _loc4_ = new PlayerPrbInfoVO(param3);
                var _loc5_:* = 0;
                while(_loc5_ < this.memberList.dataProvider.length)
                {
                    _loc6_ = this.memberList.dataProvider.requestItemAt(_loc5_) as PlayerPrbInfoVO;
                    if(_loc6_.dbID == _loc4_.dbID)
                    {
                        _loc7_ = this.memberList.getRendererAt(_loc5_) as SquadItemRenderer;
                        _loc7_.model.state = _loc4_.state;
                        _loc7_.model.vShortName = _loc4_.vShortName;
                        _loc7_.model.vLevel = _loc4_.vLevel;
                        _loc7_.model.igrType = _loc4_.igrType;
                        this.memberList.dataProvider.invalidate();
                    }
                    _loc5_++;
                }
                return;
            }
        }
        
        override public function as_setCoolDownForReadyButton(param1:uint) : void
        {
            this.coolDownReadyButton(param1);
        }
        
        override public function as_setRosterList(param1:int, param2:Boolean, param3:Array) : void
        {
            this.onRefreshMemberList(param3);
        }
        
        override public function as_refreshPermissions() : void
        {
            this.updatePermissions();
        }
        
        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                _loc1_ = window.width - window.contentPadding.left - window.contentPadding.right;
                _loc2_ = window.height - window.contentPadding.top - window.contentPadding.bottom;
                _width = _loc1_;
                _height = _loc2_;
                constraints.update(_loc1_,_loc2_);
                if(this.memberList)
                {
                    this.memberList.x = _loc1_ - this.memberList.width;
                }
                channelComponent.invalidate(InvalidationType.SIZE);
            }
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            constraints = new Constraints(this,ConstrainMode.REFLOW);
            constraints.addElement("readyButton",this.readyButton,Constraints.TOP | Constraints.RIGHT);
            constraints.addElement("leaveButton",this.leaveButton,Constraints.TOP | Constraints.LEFT | Constraints.RIGHT);
            constraints.addElement("messageArea",channelComponent.messageArea,Constraints.ALL);
            constraints.addElement("messageAreaScrollBar",channelComponent.messageAreaScrollBar,Constraints.RIGHT | Constraints.TOP | Constraints.BOTTOM);
            constraints.addElement("memberList",this.memberList,Constraints.TOP | Constraints.BOTTOM);
            constraints.addElement("messageInput",channelComponent.messageInput,Constraints.LEFT | Constraints.RIGHT | Constraints.BOTTOM);
            constraints.addElement("sendButton",channelComponent.sendButton,Constraints.RIGHT | Constraints.BOTTOM);
            if(this.memberList)
            {
                this.memberList.addEventListener(ListEventEx.ITEM_CLICK,this.onMemberItemClickHandler);
            }
            if(this.readyButton)
            {
                this.readyButton.addEventListener(ButtonEvent.CLICK,this.handleReadyClick);
            }
            if(this.leaveButton)
            {
                this.leaveButton.addEventListener(ButtonEvent.CLICK,this.handleLeaveClick);
            }
            channelComponent.invalidate(InvalidationType.SIZE);
            this.updateMemberList();
            this.updatePermissions();
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
            App.utils.scheduler.cancelTask(this.updateWindowProperties);
            this.memberList.removeEventListener(ListEventEx.ITEM_CLICK,this.onMemberItemClickHandler);
            this.memberList.dispose();
            this.readyButton.removeEventListener(ButtonEvent.CLICK,this.handleReadyClick);
            this.readyButton.dispose();
            this.leaveButton.removeEventListener(ButtonEvent.CLICK,this.handleLeaveClick);
            this.leaveButton.dispose();
        }
        
        override protected function onPopulate() : void
        {
            Window(window).visible = false;
            super.onPopulate();
            registerComponent(channelComponent,Aliases.CHANNEL_COMPONENT);
            window.useBottomBtns = true;
            canClose = true;
            enabledCloseBtn = false;
            canDrag = true;
            canResize = true;
            canMinimize = true;
            isCentered = false;
            showWindowBg = false;
            var _loc1_:Padding = window.contentPadding as Padding;
            _loc1_.bottom = 22;
            _loc1_.right = 12;
            window.contentPadding = _loc1_;
            window.title = MENU.HEADERBUTTONS_BATTLE_TYPES_SQUAD;
            this.updateMainButtons();
            geometry = new WindowGeometryInBar(MessengerBarEvent.PIN_CAROUSEL_WINDOW,getClientIDS());
        }
        
        private function updatePermissions() : void
        {
            this._isReadyBtnEnabled = isReadyBtnEnabledS();
            this._isLeaveBtnEnabled = isLeaveBtnEnabledS();
            this._canSendInvites = canSendInviteS();
            this.leaveButton.enabled = this._isLeaveBtnEnabled;
            this.readyButton.enabled = this._isReadyBtnEnabled;
            this.updateInviteButton(this._canSendInvites);
            this.updateMainButtons();
        }
        
        private function updateWindowProperties() : void
        {
            Window(window).visible = true;
        }
        
        private function updateMainButtons() : void
        {
            if(this.leaveButton != null)
            {
                this.leaveButton.label = isPlayerCreatorS()?MESSENGER.DIALOGS_SQUADCHANNEL_BUTTONS_DISMISS:MESSENGER.DIALOGS_SQUADCHANNEL_BUTTONS_LEAVE;
            }
            if(this.readyButton != null)
            {
                this.readyButton.label = isPlayerReadyS()?MESSENGER.DIALOGS_SQUADCHANNEL_BUTTONS_NOTREADY:MESSENGER.DIALOGS_SQUADCHANNEL_BUTTONS_READY;
            }
        }
        
        private function onRefreshMemberList(param1:Array) : void
        {
            var _loc5_:PlayerPrbInfoVO = null;
            var _loc6_:String = null;
            if(canSendInviteS())
            {
                param1.push(this.getInviteRoster());
            }
            var _loc2_:Array = [];
            var _loc3_:int = param1.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                _loc5_ = new PlayerPrbInfoVO(param1[_loc4_]);
                _loc2_.push(_loc5_);
                if(_loc5_.colors != null)
                {
                    _loc6_ = "";
                    if(_loc5_.colors[0] != null)
                    {
                        _loc6_ = _loc6_ + (" [0] " + _loc5_.colors[0]);
                    }
                    if(_loc5_.colors[1] != null)
                    {
                        _loc6_ = _loc6_ + (" [1] " + _loc5_.colors[1]);
                    }
                }
                _loc4_++;
            }
            this.memberDataProvider = new DataProvider(_loc2_);
            this.updateMemberList();
        }
        
        private function checkRosters() : Boolean
        {
            var _loc3_:SquadItemRenderer = null;
            var _loc1_:uint = this.memberList.dataProvider.length;
            var _loc2_:* = 0;
            while(_loc2_ < _loc1_)
            {
                _loc3_ = this.memberList.getRendererAt(_loc2_) as SquadItemRenderer;
                if(_loc3_ != null)
                {
                    if((_loc3_) && (_loc3_.data) && _loc3_.data.dummy == true)
                    {
                        return true;
                    }
                }
                _loc2_++;
            }
            return false;
        }
        
        private function updateMemberList() : void
        {
            this.memberList.labelField = "fullName";
            this.memberList.dataProvider = this.memberDataProvider;
            App.utils.scheduler.envokeInNextFrame(this.updateWindowProperties);
        }
        
        private function coolDownReadyButton(param1:uint) : void
        {
            if(this.readyButton.enabled)
            {
                this.readyButton.enabled = false;
                this.readyBtnCoolDownID = setTimeout(this.enabledReadyButton,param1 * 1000,true);
            }
        }
        
        private function enabledReadyButton(param1:Boolean) : void
        {
            this.readyButton.enabled = (param1) && (this._isReadyBtnEnabled);
            clearTimeout(this.readyBtnCoolDownID);
        }
        
        private function updateInviteButton(param1:Boolean) : void
        {
            var _loc5_:SquadItemRenderer = null;
            var _loc6_:PlayerPrbInfoVO = null;
            var _loc2_:uint = this.memberList.dataProvider.length;
            var _loc3_:* = false;
            var _loc4_:* = 0;
            while(_loc4_ < _loc2_)
            {
                _loc5_ = this.memberList.getRendererAt(_loc4_) as SquadItemRenderer;
                if(_loc5_ == null)
                {
                    _loc3_ = true;
                }
                else if((_loc5_) && (_loc5_.data) && _loc5_.data.dummy == true)
                {
                    SquadItemRenderer(this.memberList.getRendererAt(_loc4_)).visible = param1;
                    _loc3_ = true;
                }
                
                _loc4_++;
            }
            if(!_loc3_ && (param1))
            {
                _loc6_ = new PlayerPrbInfoVO(this.getInviteRoster());
                this.memberDataProvider.push(_loc6_);
                this.memberDataProvider.invalidate();
            }
        }
        
        private function getInviteRoster() : Object
        {
            var _loc1_:Object = {};
            _loc1_.dbID = -1;
            _loc1_.accID = -1;
            _loc1_.fullName = MESSENGER.DIALOGS_SQUADCHANNEL_BUTTONS_INVITE;
            _loc1_.userName = "";
            _loc1_.dummy = true;
            return _loc1_;
        }
        
        private function handleLeaveClick(param1:ButtonEvent) : void
        {
            requestToLeaveS();
        }
        
        private function handleReadyClick(param1:ButtonEvent) : void
        {
            requestToReadyS(this.readyButton.label == MESSENGER.DIALOGS_SQUADCHANNEL_BUTTONS_READY);
        }
        
        private function onMemberItemClickHandler(param1:ListEventEx) : void
        {
            var _loc2_:PlayerPrbInfoVO = null;
            var _loc3_:* = false;
            var _loc4_:IUserContextMenuGenerator = null;
            var _loc5_:Object = null;
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
            else
            {
                _loc5_ = SquadItemRenderer(param1.itemRenderer).data;
                if((_loc5_) && (_loc5_.hasOwnProperty("dummy")) && (_loc5_.dummy))
                {
                    showPrebattleSendInvitesWindowS();
                }
            }
        }
    }
}
