package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
    import net.wg.gui.lobby.eventBattleResult.data.ResultMaxValuesVO;
    import net.wg.gui.lobby.eventBattleResult.events.EventBattleResultEvent;
    import net.wg.gui.lobby.eventBattleResult.data.ResultDataVO;
    import net.wg.gui.lobby.eventBattleResult.data.ResultPlayerVO;

    public class ResultBuddies extends UIComponentEx
    {

        public static const SORT_ON_KILLS:int = 0;

        public static const SORT_ON_DAMAGE:int = 1;

        public static const SORT_ON_ASSIST:int = 2;

        public static const SORT_ON_ARMOR:int = 3;

        public static const SORT_ON_VEHICLE:int = 4;

        public static const SORT_FIELD_KILLS:String = "kills";

        public static const SORT_FIELD_DAMAGE:String = "damageDealt";

        public static const SORT_FIELD_ASSIST:String = "assist";

        public static const SORT_FIELD_ARMOR:String = "armor";

        public static const SORT_FIELD_LEVEL:String = "generalLevel";

        public static const SORT_FIELD_TANK_TYPE:String = "tankTypeSortIndex";

        public static const SORT_FIELD_NAME:String = "playerName";

        public var player0:ResultBuddie = null;

        public var player1:ResultBuddie = null;

        public var player2:ResultBuddie = null;

        public var player3:ResultBuddie = null;

        public var player4:ResultBuddie = null;

        public var header:BuddiesHeader = null;

        private var _players:Vector.<ResultBuddie> = null;

        private var _buddieIDs:Vector.<Number> = null;

        private var _playersData:DataProvider = null;

        private var _commonData:CommonStatsVO = null;

        private var _maxValuesData:ResultMaxValuesVO = null;

        private var _canInvite:Boolean = false;

        private var _friends:Array = null;

        public function ResultBuddies()
        {
            super();
            this._players = new <ResultBuddie>[this.player0,this.player1,this.player2,this.player3,this.player4];
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.header.addEventListener(EventBattleResultEvent.SORT_ON,this.onSortOnHandler);
        }

        override protected function onBeforeDispose() : void
        {
            this.header.removeEventListener(EventBattleResultEvent.SORT_ON,this.onSortOnHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            var _loc1_:ResultBuddie = null;
            for each(_loc1_ in this._players)
            {
                _loc1_.dispose();
            }
            this._players.splice(0,this._players.length);
            this._players = null;
            if(this._buddieIDs != null)
            {
                this._buddieIDs.splice(0,this._buddieIDs.length);
                this._buddieIDs = null;
            }
            this.player0 = null;
            this.player1 = null;
            this.player2 = null;
            this.player3 = null;
            this.player4 = null;
            this.header.dispose();
            this.header = null;
            this._maxValuesData = null;
            this._playersData = null;
            this._commonData = null;
            this._friends = null;
            super.onDispose();
        }

        public function restoreFriendButton(param1:Number) : void
        {
            if(this._buddieIDs == null)
            {
                return;
            }
            this._players[this._buddieIDs.indexOf(param1)].restoreFriendButton();
        }

        public function restoreSquadButton(param1:Number) : void
        {
            if(this._buddieIDs == null)
            {
                return;
            }
            this._players[this._buddieIDs.indexOf(param1)].restoreSquadButton();
        }

        public function setData(param1:ResultDataVO, param2:Boolean, param3:Array) : void
        {
            this.header.setData(param1);
            this._playersData = param1.players;
            this._commonData = param1.common;
            this._maxValuesData = param1.maxValues;
            this._canInvite = param2;
            this._friends = param3;
            this.sortPlayers(SORT_ON_VEHICLE);
            this.updateRows();
        }

        private function updateRows() : void
        {
            var _loc3_:uint = 0;
            var _loc4_:ResultBuddie = null;
            var _loc5_:ResultPlayerVO = null;
            var _loc6_:* = false;
            if(this._buddieIDs == null)
            {
                this._buddieIDs = new Vector.<Number>(0);
            }
            else
            {
                this._buddieIDs.splice(0,this._buddieIDs.length);
            }
            var _loc1_:uint = this._playersData.length;
            var _loc2_:uint = this._players.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
                _loc4_ = this._players[_loc3_];
                _loc4_.visible = _loc3_ < _loc1_;
                if(_loc4_.visible)
                {
                    _loc5_ = ResultPlayerVO(this._playersData[_loc3_]);
                    _loc6_ = this._friends.indexOf(_loc5_.playerId) != -1;
                    _loc4_.setData(_loc5_,this._commonData,this._canInvite,_loc6_,this._maxValuesData);
                    this._buddieIDs.push(_loc5_.playerId);
                }
                _loc3_++;
            }
        }

        private function onSortOnHandler(param1:EventBattleResultEvent) : void
        {
            this.sortPlayers(param1.id);
            this.updateRows();
        }

        private function sortPlayers(param1:int) : void
        {
            switch(param1)
            {
                case SORT_ON_KILLS:
                    this._playersData.sortOn(SORT_FIELD_KILLS,Array.DESCENDING | Array.NUMERIC);
                    break;
                case SORT_ON_DAMAGE:
                    this._playersData.sortOn(SORT_FIELD_DAMAGE,Array.DESCENDING | Array.NUMERIC);
                    break;
                case SORT_ON_ASSIST:
                    this._playersData.sortOn(SORT_FIELD_ASSIST,Array.DESCENDING | Array.NUMERIC);
                    break;
                case SORT_ON_ARMOR:
                    this._playersData.sortOn(SORT_FIELD_ARMOR,Array.DESCENDING | Array.NUMERIC);
                    break;
                case SORT_ON_VEHICLE:
                    this._playersData.sortOn([SORT_FIELD_LEVEL,SORT_FIELD_TANK_TYPE,SORT_FIELD_NAME],[Array.DESCENDING | Array.NUMERIC,Array.NUMERIC,Array.CASEINSENSITIVE]);
                    break;
            }
        }
    }
}
