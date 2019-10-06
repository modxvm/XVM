package net.wg.gui.battle.views.stats
{
    import net.wg.gui.battle.views.stats.constants.DynamicSquadState;

    public class SquadTooltip extends Object
    {

        private var _tooltipState:int = 0;

        public function SquadTooltip()
        {
            super();
        }

        public function show(param1:int, param2:Boolean) : void
        {
            var _loc3_:String = null;
            if(this._tooltipState != param1)
            {
                _loc3_ = this.getTooltipID(param1,param2);
                if(_loc3_)
                {
                    App.toolTipMgr.showComplex(App.toolTipMgr.getNewFormatter().addBody(_loc3_,true).make());
                    this._tooltipState = param1;
                }
            }
        }

        public function hide() : void
        {
            if(this._tooltipState != DynamicSquadState.NONE)
            {
                App.toolTipMgr.hide();
                this._tooltipState = DynamicSquadState.NONE;
            }
        }

        private function getTooltipID(param1:int, param2:Boolean) : String
        {
            switch(param1)
            {
                case DynamicSquadState.INVITE_DISABLED:
                    return param2?INGAME_GUI.DYNAMICSQUAD_ENEMY_DISABLED:INGAME_GUI.DYNAMICSQUAD_ALLY_DISABLED;
                case DynamicSquadState.INVITE_AVAILABLE:
                    return param2?INGAME_GUI.DYNAMICSQUAD_ENEMY_ADD:INGAME_GUI.DYNAMICSQUAD_ALLY_ADD;
                case DynamicSquadState.INVITE_SENT:
                    return param2?INGAME_GUI.DYNAMICSQUAD_ENEMY_WASSENT:INGAME_GUI.DYNAMICSQUAD_ALLY_WASSENT;
                case DynamicSquadState.INVITE_RECEIVED:
                    return param2?INGAME_GUI.DYNAMICSQUAD_ENEMY_RECEIVED:INGAME_GUI.DYNAMICSQUAD_ALLY_RECEIVED;
                default:
                    return null;
            }
        }
    }
}
