package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
    import net.wg.gui.lobby.eventBattleResult.data.ResultPlayerVO;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Values;
    import net.wg.gui.lobby.eventBattleResult.events.EventBattleResultEvent;
    import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;

    public class BuddieLeftPanel extends UIComponentEx
    {

        private static const FRIEND_BTN_DEFAULT_X:int = 7;

        public var btnFriend:ISoundButtonEx = null;

        public var btnMail:ISoundButtonEx = null;

        public var btnMenu:ISoundButtonEx = null;

        public var iconFriend:MovieClip = null;

        public var iconMail:MovieClip = null;

        public var iconNone:MovieClip = null;

        private var _statsData:CommonStatsVO = null;

        private var _buddieData:ResultPlayerVO = null;

        public function BuddieLeftPanel()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.btnMenu.addEventListener(MouseEvent.CLICK,this.onBtnContextClickHandler);
            this.btnFriend.addEventListener(MouseEvent.CLICK,this.onBtnFriendClickHandler);
            this.btnMail.addEventListener(MouseEvent.CLICK,this.onBtnMailClickHandler);
        }

        override protected function onBeforeDispose() : void
        {
            this.btnMenu.removeEventListener(MouseEvent.CLICK,this.onBtnContextClickHandler);
            this.btnFriend.removeEventListener(MouseEvent.CLICK,this.onBtnFriendClickHandler);
            this.btnMail.removeEventListener(MouseEvent.CLICK,this.onBtnMailClickHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.btnMenu.dispose();
            this.btnMenu = null;
            this.btnFriend.dispose();
            this.btnFriend = null;
            this.btnMail.dispose();
            this.btnMail = null;
            this.iconNone = null;
            this.iconFriend = null;
            this.iconMail = null;
            this._buddieData = null;
            this._statsData = null;
            super.onDispose();
        }

        public function restoreFriendButton() : void
        {
            this.btnFriend.visible = true;
            this.iconFriend.visible = false;
        }

        public function restoreSquadButton() : void
        {
            this.btnMail.visible = true;
            this.iconMail.visible = false;
        }

        public function setData(param1:ResultPlayerVO, param2:CommonStatsVO, param3:Boolean, param4:Boolean) : void
        {
            this._buddieData = param1;
            this._statsData = param2;
            this.iconNone.visible = !param1.isSelf && !param4 && !param3;
            this.btnMenu.visible = !param1.isSelf;
            this.btnFriend.visible = !param4 && !param1.isSelf;
            this.btnMail.visible = param3 && !param1.isSelf && !param1.isOwnSquad;
            this.iconMail.visible = false;
            this.iconFriend.visible = false;
            if(!this.btnMail.visible)
            {
                this.btnFriend.x = this.btnMail.x;
                this.iconFriend.x = this.iconMail.x;
            }
            else
            {
                this.btnFriend.x = FRIEND_BTN_DEFAULT_X;
                this.iconFriend.x = Values.ZERO;
            }
        }

        private function onBtnMailClickHandler(param1:MouseEvent) : void
        {
            this.btnMail.visible = false;
            this.iconMail.visible = true;
            dispatchEvent(new EventBattleResultEvent(EventBattleResultEvent.SEND_SQUAD,this._buddieData.playerId,null,true));
        }

        private function onBtnFriendClickHandler(param1:MouseEvent) : void
        {
            this.btnFriend.visible = false;
            this.iconFriend.visible = true;
            dispatchEvent(new EventBattleResultEvent(EventBattleResultEvent.SEND_FRIEND,this._buddieData.playerId,this._buddieData.userVO.userName,true));
        }

        private function onBtnContextClickHandler(param1:MouseEvent) : void
        {
            if(!this._statsData || !this._buddieData)
            {
                return;
            }
            var _loc2_:Object = {
                "dbID":this._buddieData.playerId,
                "userName":this._buddieData.userVO.userName,
                "himself":this._buddieData.isSelf,
                "wasInBattle":this._statsData.wasInBattle,
                "showClanProfile":true,
                "clanAbbrev":this._buddieData.userVO.clanAbbrev,
                "vehicleCD":this._buddieData.vehicleCD,
                "clientArenaIdx":this._statsData.clientArenaIdx,
                "arenaType":this._statsData.arenaType,
                "isAlly":this._buddieData.isAlly
            };
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.BATTLE_RESULTS_USER,this,_loc2_);
        }
    }
}
