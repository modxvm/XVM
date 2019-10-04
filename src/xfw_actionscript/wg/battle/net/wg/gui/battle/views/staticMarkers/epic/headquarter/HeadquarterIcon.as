package net.wg.gui.battle.views.staticMarkers.epic.headquarter
{
    import net.wg.gui.battle.components.BattleIconHolder;
    import flash.display.MovieClip;
    import flash.display.DisplayObject;

    public class HeadquarterIcon extends BattleIconHolder
    {

        private static const HQ_ID_SCALE:Number = 0.75;

        private static const HQ_ICN_SCALE:Number = 0.75;

        private static const TARGET_SCALE:Number = 0.9;

        private static const LABEL_LIVE:String = "live";

        private static const LABEL_DEAD:String = "death";

        private static const LABEL_HIT:String = "hit";

        private static const LABEL_HIT_PIERCED:String = "hit_pierced";

        public var hqId:MovieClip = null;

        public var hqEnemy:MovieClip = null;

        public var hqAlly:MovieClip = null;

        public var targetHighlight:MovieClip = null;

        private var _isPlayerTeam:Boolean;

        public function HeadquarterIcon()
        {
            super();
            this.hqAlly.visible = false;
            this.hqEnemy.visible = false;
        }

        public function setInternalIconScale(param1:Number) : void
        {
            var _loc2_:Number = HQ_ID_SCALE * param1;
            this.hqId.scaleX = this.hqId.scaleY = _loc2_;
            _loc2_ = HQ_ICN_SCALE * param1;
            this.hqAlly.scaleX = this.hqAlly.scaleY = _loc2_;
            this.hqEnemy.scaleX = this.hqEnemy.scaleY = _loc2_;
            _loc2_ = TARGET_SCALE * param1;
            this.targetHighlight.scaleX = this.targetHighlight.scaleY = _loc2_;
        }

        public function setOwningTeam(param1:Boolean) : void
        {
            this._isPlayerTeam = param1;
            showItem(this._isPlayerTeam?this.hqAlly:this.hqEnemy);
        }

        public function setDead(param1:Boolean) : void
        {
            var _loc2_:MovieClip = this._isPlayerTeam?this.hqAlly:this.hqEnemy;
            if(!param1)
            {
                _loc2_.gotoAndStop(LABEL_LIVE);
            }
            else
            {
                _loc2_.gotoAndPlay(LABEL_DEAD);
            }
        }

        public function setHeadquarterId(param1:int) : void
        {
            this.hqId.gotoAndStop(param1);
        }

        override protected function onDispose() : void
        {
            this.hqEnemy.stop();
            this.hqEnemy = null;
            this.hqAlly.stop();
            this.hqAlly = null;
            this.hqId = null;
            this.targetHighlight = null;
            super.onDispose();
        }

        public function setHit(param1:Boolean) : void
        {
            var _loc2_:MovieClip = this._isPlayerTeam?this.hqAlly:this.hqEnemy;
            _loc2_.gotoAndPlay(param1?LABEL_HIT_PIERCED:LABEL_HIT);
        }
    }
}
