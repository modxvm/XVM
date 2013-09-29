package net.wg.gui.messenger.windows 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.components.*;
    import net.wg.data.daapi.base.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.messenger.data.*;
    import net.wg.gui.messenger.meta.*;
    import net.wg.gui.messenger.meta.impl.*;
    import scaleform.clik.utils.*;
    import scaleform.gfx.*;
    
    public class LobbyChannelWindow extends net.wg.gui.messenger.meta.impl.LobbyChannelWindowMeta implements net.wg.gui.messenger.meta.ILobbyChannelWindowMeta
    {
        public function LobbyChannelWindow()
        {
            super();
            this._membersDP = new net.wg.data.daapi.base.DAAPIDataProvider();
            return;
        }

        public function as_getMembersDP():Object
        {
            return this._membersDP;
        }

        public function as_hideMembersList():void
        {
            this._needToHideList = true;
            invalidate(INVALID_LIST_VISIBILITY);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            constraints.addElement("background", this.background, scaleform.clik.utils.Constraints.ALL);
            constraints.addElement("membersList", this.membersList, scaleform.clik.utils.Constraints.RIGHT | scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.BOTTOM);
            this._membersDP.addEventListener(flash.events.Event.CHANGE, this.onMembersDPChange);
            this.membersList.addEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.onMemberItemClick);
            this.membersList.dataProvider = this._membersDP;
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (isInvalid(INVALID_LIST_VISIBILITY) && this._needToHideList) 
            {
                this._needToHideList = false;
                this.membersList.visible = false;
                loc1 = channelComponent.messageArea;
                loc2 = channelComponent.sendButton;
                loc1.width = loc2.x + loc2.width - loc1.x * 2;
                this.background.width = loc2.x + loc2.width;
                constraints.removeElement("background");
                constraints.removeElement("messageArea");
                constraints.addElement("background", this.background, scaleform.clik.utils.Constraints.ALL);
                constraints.addElement("messageArea", channelComponent.messageArea, scaleform.clik.utils.Constraints.ALL);
            }
            super.draw();
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this._membersDP.removeEventListener(flash.events.Event.CHANGE, this.onMembersDPChange);
            this.membersList.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.onMemberItemClick);
            this.membersList.disposeRenderers();
            this._membersDP.cleanUp();
            this._membersDP = null;
            return;
        }

        internal function onMembersDPChange(arg1:flash.events.Event):void
        {
            return;
        }

        internal function onMemberItemClick(arg1:net.wg.gui.events.ListEventEx):void
        {
            var loc1:*=null;
            if (arg1.buttonIdx == scaleform.gfx.MouseEventEx.RIGHT_BUTTON) 
            {
                loc1 = new net.wg.gui.messenger.data.ChannelMemberVO(arg1.itemData);
                App.contextMenuMgr.showUserContextMenu(this, loc1, new net.wg.data.components.ContextItemGenerator());
            }
            return;
        }

        internal static const INVALID_LIST_VISIBILITY:String="invalidListVisibility";

        public var membersList:net.wg.gui.components.controls.ScrollingListEx;

        public var background:flash.display.Sprite;

        protected var _membersDP:net.wg.data.daapi.base.DAAPIDataProvider;

        internal var _needToHideList:Boolean=false;
    }
}
