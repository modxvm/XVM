package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.lobby.eventBattleResult.data.ResultDataVO;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.lobby.eventBattleResult.data.ResultPlayerVO;

    public class ResultBuddies extends UIComponentEx
    {

        public var player0:ResultBuddie = null;

        public var player1:ResultBuddie = null;

        public var player2:ResultBuddie = null;

        public var player3:ResultBuddie = null;

        public var player4:ResultBuddie = null;

        public var header:BuddiesHeader = null;

        private var _players:Vector.<ResultBuddie> = null;

        private var _buddieIDs:Vector.<Number> = null;

        public function ResultBuddies()
        {
            super();
            this._players = new <ResultBuddie>[this.player0,this.player1,this.player2,this.player3,this.player4];
        }

        public function setData(param1:ResultDataVO, param2:Boolean, param3:Array) : void
        {
            var _loc4_:DataProvider = null;
            var _loc7_:uint = 0;
            var _loc8_:ResultBuddie = null;
            var _loc9_:ResultPlayerVO = null;
            var _loc10_:* = false;
            _loc4_ = param1.players;
            if(this._buddieIDs == null)
            {
                this._buddieIDs = new Vector.<Number>(0);
            }
            else
            {
                this._buddieIDs.splice(0,this._buddieIDs.length);
            }
            var _loc5_:uint = _loc4_.length;
            var _loc6_:uint = this._players.length;
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
                _loc8_ = this._players[_loc7_];
                _loc8_.visible = _loc7_ < _loc5_;
                if(_loc8_.visible)
                {
                    _loc9_ = ResultPlayerVO(_loc4_[_loc7_]);
                    _loc10_ = param3.indexOf(_loc9_.playerId) != -1;
                    _loc8_.setData(_loc9_,param1.common,param2,_loc10_);
                    this._buddieIDs.push(_loc9_.playerId);
                }
                _loc7_++;
            }
            this.header.setData(param1);
        }

        public function setSizeFrame(param1:int) : void
        {
            gotoAndStop(param1);
            if(_baseDisposed)
            {
                return;
            }
            var _loc2_:uint = 0;
            while(_loc2_ < length)
            {
                this._players[_loc2_].gotoAndStop(param1);
                if(_baseDisposed)
                {
                    return;
                }
                _loc2_++;
            }
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
            super.onDispose();
        }

        public function restoreSquadButton(param1:Number) : void
        {
            if(this._buddieIDs == null)
            {
                return;
            }
            this._players[this._buddieIDs.indexOf(param1)].restoreSquadButton();
        }

        public function restoreFriendButton(param1:Number) : void
        {
            if(this._buddieIDs == null)
            {
                return;
            }
            this._players[this._buddieIDs.indexOf(param1)].restoreFriendButton();
        }
    }
}
