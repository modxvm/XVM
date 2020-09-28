package net.wg.gui.battle.eventBattle.views.ReinforcementPanel
{
    import net.wg.infrastructure.base.meta.impl.WTReinforcementPanelMeta;
    import net.wg.infrastructure.base.meta.IWTReinforcementPanelMeta;
    import flash.display.MovieClip;
    import net.wg.data.constants.InvalidationType;

    public class ReinforcementPanel extends WTReinforcementPanelMeta implements IWTReinforcementPanelMeta
    {

        private static const FULL_STATE:String = "full";

        private static const EMPTY_STATE:String = "empty";

        public var tank1:MovieClip = null;

        public var tank2:MovieClip = null;

        public var tank3:MovieClip = null;

        private var _respawns:int = -1;

        private var _tankIconsList:Vector.<MovieClip> = null;

        public function ReinforcementPanel()
        {
            super();
            this._tankIconsList = new <MovieClip>[this.tank1,this.tank2,this.tank3];
        }

        override protected function onDispose() : void
        {
            this._tankIconsList.splice(0,this._tankIconsList.length);
            this._tankIconsList = null;
            this.tank1 = null;
            this.tank2 = null;
            this.tank3 = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            super.draw();
            if(isInvalid(InvalidationType.STATE))
            {
                _loc1_ = this._respawns;
                _loc2_ = this._tankIconsList.length;
                _loc3_ = 0;
                while(_loc3_ < _loc2_)
                {
                    this._tankIconsList[_loc3_].gotoAndStop(_loc1_ > 0?FULL_STATE:EMPTY_STATE);
                    _loc1_--;
                    _loc3_++;
                }
            }
        }

        public function as_setPlayerLives(param1:int) : void
        {
            if(param1 < 0)
            {
                return;
            }
            if(this._respawns == param1)
            {
                return;
            }
            this._respawns = param1;
            invalidateState();
        }
    }
}
