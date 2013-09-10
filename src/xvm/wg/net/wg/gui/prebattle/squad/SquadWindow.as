package net.wg.gui.prebattle.squad 
{
    import flash.utils.*;
    import net.wg.data.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.messengerBar.*;
    import net.wg.gui.messenger.*;
    import net.wg.gui.prebattle.data.*;
    import net.wg.gui.prebattle.meta.*;
    import net.wg.gui.prebattle.meta.abstract.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    import scaleform.gfx.*;
    
    public class SquadWindow extends net.wg.gui.prebattle.meta.abstract.PrebattleWindowAbstract implements net.wg.gui.prebattle.meta.IPrebattleWindowMeta
    {
        public function SquadWindow()
        {
            super();
            return;
        }

        internal function handleReadyClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            requestToReadyS(this.readyButton.label == MESSENGER.DIALOGS_SQUADCHANNEL_BUTTONS_READY);
            return;
        }

        internal function onMemberItemClickHandler(arg1:net.wg.gui.events.ListEventEx):void
        {
            var loc1:*=null;
            var loc2:*=false;
            var loc3:*=null;
            var loc4:*=null;
            if (arg1.buttonIdx != scaleform.gfx.MouseEventEx.RIGHT_BUTTON) 
                if ((loc4 = net.wg.gui.prebattle.squad.SquadItemRenderer(arg1.itemRenderer).data) && loc4.hasOwnProperty("dummy") && loc4.dummy) 
                    showPrebattleSendInvitesWindowS();
            else 
            {
                loc1 = net.wg.gui.prebattle.data.PlayerPrbInfoVO(arg1.itemData);
                if (loc1.accID > -1) 
                {
                    loc2 = loc1.uid > -1;
                    loc3 = new net.wg.gui.prebattle.squad.SquadWindowCIGenerator(loc2, canKickPlayerS());
                    App.contextMenuMgr.showUserContextMenu(this, loc1, loc3);
                }
                else 
                    App.contextMenuMgr.hide();
            }
            return;
        }

        internal function onRefreshMemberList(arg1:Array):void
        {
            var loc4:*=null;
            var loc5:*=null;
            if (canSendInviteS()) 
                arg1.push(this.getInviteRoster());
            var loc1:*=[];
            var loc2:*=arg1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = new net.wg.gui.prebattle.data.PlayerPrbInfoVO(arg1[loc3]);
                loc1.push(loc4);
                if (loc4.colors != null) 
                {
                    loc5 = "";
                    if (loc4.colors[0] != null) 
                        loc5 = loc5 + (" [0] " + loc4.colors[0]);
                    if (loc4.colors[1] != null) 
                        loc5 = loc5 + (" [1] " + loc4.colors[1]);
                }
                ++loc3;
            }
            this.memberDataProvider = new scaleform.clik.data.DataProvider(loc1);
            this.updateMemberList();
            return;
        }

        internal function checkRosters():Boolean
        {
            var loc3:*=null;
            var loc1:*=this.memberList.dataProvider.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this.memberList.getRendererAt(loc2) as net.wg.gui.prebattle.squad.SquadItemRenderer;
                if (loc3 != null) 
                    if (loc3 && loc3.data && loc3.data.dummy == true) 
                        return true;
                ++loc2;
            }
            return false;
        }

        internal function updateMemberList():void
        {
            this.memberList.labelField = "fullName";
            this.memberList.dataProvider = this.memberDataProvider;
            return;
        }

        internal function coolDownReadyButton(arg1:uint):void
        {
            if (this.readyButton.enabled) 
            {
                this.readyButton.enabled = false;
                this.readyBtnCoolDownID = flash.utils.setTimeout(this.enabledReadyButton, arg1 * 1000, true);
            }
            return;
        }

        internal function enabledReadyButton(arg1:Boolean):void
        {
            this.readyButton.enabled = arg1 && this._isReadyBtnEnabled;
            flash.utils.clearTimeout(this.readyBtnCoolDownID);
            return;
        }

        internal function updateInviteButton(arg1:Boolean):void
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=this.memberList.dataProvider.length;
            var loc2:*=false;
            var loc3:*=0;
            while (loc3 < loc1) 
            {
                if ((loc4 = this.memberList.getRendererAt(loc3) as net.wg.gui.prebattle.squad.SquadItemRenderer) != null) 
                    if (loc4 && loc4.data && loc4.data.dummy == true) 
                    {
                        net.wg.gui.prebattle.squad.SquadItemRenderer(this.memberList.getRendererAt(loc3)).visible = arg1;
                        loc2 = true;
                    }
                else 
                    loc2 = true;
                ++loc3;
            }
            if (!loc2 && arg1) 
            {
                loc5 = new net.wg.gui.prebattle.data.PlayerPrbInfoVO(this.getInviteRoster());
                this.memberDataProvider.push(loc5);
                this.memberDataProvider.invalidate();
            }
            return;
        }

        internal function getInviteRoster():Object
        {
            var loc1:*={};
            loc1.uid = -1;
            loc1.accID = -1;
            loc1.fullName = MESSENGER.DIALOGS_SQUADCHANNEL_BUTTONS_INVITE;
            loc1.userName = "";
            loc1.dummy = true;
            return loc1;
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

        public override function as_toggleReadyBtn(arg1:Boolean):void
        {
            this.readyButton.label = arg1 ? MESSENGER.DIALOGS_SQUADCHANNEL_BUTTONS_READY : MESSENGER.DIALOGS_SQUADCHANNEL_BUTTONS_NOTREADY;
            return;
        }

        public override function setFocus():void
        {
            super.setFocus();
            if (this.squadChannelComponent) 
                this.squadChannelComponent.setFocusToInput();
            return;
        }

        public override function as_setPlayerState(arg1:int, arg2:Boolean, arg3:Object):void
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc4:*=null;
            if (arg3) 
                loc1 = new net.wg.gui.prebattle.data.PlayerPrbInfoVO(arg3);
            else 
                return;
            var loc2:*=0;
            while (loc2 < this.memberList.dataProvider.length) 
            {
                if ((loc3 = this.memberList.dataProvider.requestItemAt(loc2) as net.wg.gui.prebattle.data.PlayerPrbInfoVO).uid == loc1.uid) 
                {
                    (loc4 = this.memberList.getRendererAt(loc2) as net.wg.gui.prebattle.squad.SquadItemRenderer).model.state = loc1.state;
                    loc4.model.vShortName = loc1.vShortName;
                    this.memberList.dataProvider.invalidate();
                }
                ++loc2;
            }
            return;
        }

        public override function as_setCoolDownForReadyButton(arg1:uint):void
        {
            this.coolDownReadyButton(arg1);
            return;
        }

        public override function as_setRosterList(arg1:int, arg2:Boolean, arg3:Array):void
        {
            this.onRefreshMemberList(arg3);
            return;
        }

        public override function as_refreshPermissions():void
        {
            this.updatePermissions();
            return;
        }

        internal function updatePermissions():void
        {
            this._isReadyBtnEnabled = isReadyBtnEnabledS();
            this._isLeaveBtnEnabled = isLeaveBtnEnabledS();
            this._canSendInvites = canSendInviteS();
            this.leaveButton.enabled = this._isLeaveBtnEnabled;
            this.readyButton.enabled = this._isReadyBtnEnabled;
            this.updateInviteButton(this._canSendInvites);
            this.updateMainButtons();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=0;
            var loc2:*=0;
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                loc1 = window.width - window.contentPadding.left - window.contentPadding.right;
                loc2 = window.height - window.contentPadding.top - window.contentPadding.bottom;
                _width = loc1;
                _height = loc2;
                constraints.update(loc1, loc2);
                if (this.memberList) 
                    this.memberList.x = loc1 - this.memberList.width;
                this.squadChannelComponent.invalidate(scaleform.clik.constants.InvalidationType.SIZE);
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.REFLOW);
            constraints.addElement("readyButton", this.readyButton, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("leaveButton", this.leaveButton, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("messageArea", this.squadChannelComponent.messageArea, scaleform.clik.utils.Constraints.ALL);
            constraints.addElement("messageAreaScrollBar", this.squadChannelComponent.messageAreaScrollBar, scaleform.clik.utils.Constraints.RIGHT | scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.BOTTOM);
            constraints.addElement("memberList", this.memberList, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.BOTTOM);
            constraints.addElement("messageInput", this.squadChannelComponent.messageInput, scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT | scaleform.clik.utils.Constraints.BOTTOM);
            constraints.addElement("sendButton", this.squadChannelComponent.sendButton, scaleform.clik.utils.Constraints.RIGHT | scaleform.clik.utils.Constraints.BOTTOM);
            if (this.memberList) 
                this.memberList.addEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.onMemberItemClickHandler);
            if (this.readyButton) 
                this.readyButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleReadyClick);
            if (this.leaveButton) 
                this.leaveButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleLeaveClick);
            this.squadChannelComponent.invalidate(scaleform.clik.constants.InvalidationType.SIZE);
            this.updateMemberList();
            this.updatePermissions();
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.memberList.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.onMemberItemClickHandler);
            this.memberList.dispose();
            this.readyButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleReadyClick);
            this.readyButton.dispose();
            this.leaveButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleLeaveClick);
            this.leaveButton.dispose();
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            registerComponent(this.squadChannelComponent, net.wg.data.Aliases.CHANNEL_COMPONENT);
            window.useBottomBtns = true;
            canClose = true;
            enabledCloseBtn = false;
            canDrag = true;
            canResize = true;
            canMinimize = true;
            isCentered = false;
            showWindowBg = false;
            var loc1:*=window.contentPadding as scaleform.clik.utils.Padding;
            loc1.bottom = 22;
            loc1.right = 12;
            window.contentPadding = loc1;
            window.title = MENU.HEADERBUTTONS_BATTLE_TYPES_SQUAD;
            this.updateMainButtons();
            geometry = new net.wg.gui.lobby.messengerBar.WindowGeometryInBar(net.wg.gui.events.MessengerBarEvent.PIN_CAROUSEL_WINDOW, getClientIDS());
            return;
        }

        internal function updateMainButtons():void
        {
            if (this.leaveButton != null) 
                this.leaveButton.label = isPlayerCreatorS() ? MESSENGER.DIALOGS_SQUADCHANNEL_BUTTONS_DISMISS : MESSENGER.DIALOGS_SQUADCHANNEL_BUTTONS_LEAVE;
            if (this.readyButton != null) 
                this.readyButton.label = isPlayerReadyS() ? MESSENGER.DIALOGS_SQUADCHANNEL_BUTTONS_NOTREADY : MESSENGER.DIALOGS_SQUADCHANNEL_BUTTONS_READY;
            return;
        }

        internal function handleLeaveClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            requestToLeaveS();
            return;
        }

        public var squadChannelComponent:net.wg.gui.messenger.ChannelComponent;

        public var leaveButton:net.wg.gui.components.controls.SoundButtonEx;

        public var readyButton:net.wg.gui.components.controls.SoundButtonEx;

        public var memberList:net.wg.gui.components.controls.ScrollingListEx;

        internal var readyBtnCoolDownID:uint=0;

        internal var memberDataProvider:scaleform.clik.data.DataProvider;

        internal var _isReadyBtnEnabled:Boolean=false;

        internal var _isLeaveBtnEnabled:Boolean=false;

        internal var _canSendInvites:Boolean=false;
    }
}
