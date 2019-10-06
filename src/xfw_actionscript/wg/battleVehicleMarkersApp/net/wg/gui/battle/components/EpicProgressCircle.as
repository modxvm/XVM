package net.wg.gui.battle.components
{
    import flash.display.MovieClip;
    import scaleform.gfx.Extensions;

    public class EpicProgressCircle extends BattleUIComponent
    {

        public static const SEMI_LAST_FRAME:int = 180;

        public static const ALLY_STATE:String = "ally";

        public static const ENEMY_STATE:String = "enemy";

        public var progressCircle:MovieClip = null;

        private var _currentFrame:int = 180;

        private var _capturingActive:Boolean = false;

        private var _isPlayerTeam:Boolean = false;

        private var _state:String = "";

        public function EpicProgressCircle()
        {
            super();
            Extensions.setEdgeAAMode(this.progressCircle,Extensions.EDGEAA_ON);
            this._state = ENEMY_STATE;
            gotoAndStop(ENEMY_STATE);
            this.progressCircle.gotoAndStop(SEMI_LAST_FRAME);
        }

        override protected function onDispose() : void
        {
            this.progressCircle = null;
            super.onDispose();
        }

        public function setOwner(param1:Boolean) : void
        {
            if(this._isPlayerTeam == param1 || this._capturingActive)
            {
                return;
            }
            this._isPlayerTeam = param1;
            this._capturingActive = false;
            this._state = param1?ALLY_STATE:ENEMY_STATE;
            gotoAndStop(this._state);
            this._currentFrame = SEMI_LAST_FRAME;
            this.progressCircle.gotoAndStop(SEMI_LAST_FRAME);
        }

        public function updateProgress(param1:Number) : void
        {
            var _loc2_:int = this._currentFrame;
            var _loc3_:* = param1 * SEMI_LAST_FRAME >> 0;
            if(_loc2_ != _loc3_ && _loc2_ == SEMI_LAST_FRAME && _loc3_ > 0)
            {
                this._capturingActive = true;
                this._state = this.getCapturingActiveState();
                this._currentFrame = _loc3_;
                gotoAndStop(this._state);
                this.progressCircle.gotoAndStop(_loc3_);
            }
            else if(_loc2_ > 0 && _loc3_ == 0 && this._capturingActive)
            {
                this._capturingActive = false;
                this._state = this._isPlayerTeam?ALLY_STATE:ENEMY_STATE;
                this._currentFrame = SEMI_LAST_FRAME;
                gotoAndStop(this._state);
                this.progressCircle.gotoAndStop(SEMI_LAST_FRAME);
            }
            else if(this._capturingActive)
            {
                this._currentFrame = _loc3_;
                this.progressCircle.gotoAndStop(_loc3_);
            }
        }

        private function getCapturingActiveState() : String
        {
            return this._isPlayerTeam?ENEMY_STATE:ALLY_STATE;
        }

        public function get capturingActive() : Boolean
        {
            return this._capturingActive;
        }
    }
}
