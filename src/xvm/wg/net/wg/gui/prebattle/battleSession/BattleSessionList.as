package net.wg.gui.prebattle.battleSession 
{
    import flash.display.*;
    import net.wg.data.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.messengerBar.*;
    import net.wg.gui.messenger.*;
    import net.wg.gui.prebattle.meta.*;
    import net.wg.gui.prebattle.meta.impl.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.data.*;
    import scaleform.clik.utils.*;
    
    public class BattleSessionList extends net.wg.gui.prebattle.meta.impl.BattleSessionListMeta implements net.wg.gui.prebattle.meta.IBattleSessionListMeta
    {
        public function BattleSessionList()
        {
            super();
            showWindowBg = false;
            canMinimize = true;
            enabledCloseBtn = false;
            canResize = true;
            isCentered = false;
            return;
        }

        public override function setFocus():void
        {
            super.setFocus();
            if (this.channelComponent) 
                this.channelComponent.setFocusToInput();
            return;
        }

        public function as_refreshList(arg1:Array):void
        {
            this.groupsList.dataProvider = new scaleform.clik.data.DataProvider(arg1);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.groupsList.addEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.handleTeamItemClick);
            this.setConstraints();
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.groupsList.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.handleTeamItemClick);
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            registerComponent(this.channelComponent, net.wg.data.Aliases.CHANNEL_COMPONENT);
            window.setTitleIcon("teamList");
            window.title = CHAT.CHANNELS_SPECIAL_BATTLES;
            geometry = new net.wg.gui.lobby.messengerBar.WindowGeometryInBar(net.wg.gui.events.MessengerBarEvent.PIN_CAROUSEL_WINDOW, getClientIDS());
            return;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        internal function setConstraints():void
        {
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.REFLOW);
            constraints.addElement("messageArea", this.channelComponent.messageArea, scaleform.clik.utils.Constraints.ALL);
            constraints.addElement("messageInput", this.channelComponent.messageInput, scaleform.clik.utils.Constraints.BOTTOM | scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("messageAreaScrollBar", this.channelComponent.messageAreaScrollBar, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("sendButton", this.channelComponent.sendButton, scaleform.clik.utils.Constraints.BOTTOM | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("groupsList", this.groupsList, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.BOTTOM | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("groupListBG", this.groupListBG, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.BOTTOM | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("groupsScrollBar", this.groupsScrollBar, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.BOTTOM | scaleform.clik.utils.Constraints.RIGHT);
            return;
        }

        internal function handleTeamItemClick(arg1:net.wg.gui.events.ListEventEx):void
        {
            var loc1:*=new net.wg.gui.prebattle.battleSession.BSListRendererVO(arg1.itemData);
            requestToJoinTeamS(loc1.prbID, loc1.prbType);
            return;
        }

        public var channelComponent:net.wg.gui.messenger.ChannelComponent;

        public var groupsScrollBar:net.wg.gui.components.controls.ScrollBar;

        public var groupsList:net.wg.gui.components.controls.ScrollingListEx;

        public var groupListBG:flash.display.MovieClip;
    }
}
