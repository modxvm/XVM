package net.wg.gui.lobby.battleResults.controller
{
    import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
    import flash.events.IEventDispatcher;

    public class CybersportTeamStatsController extends DefaultTeamStatsController
    {

        public function CybersportTeamStatsController(param1:IEventDispatcher)
        {
            super(param1);
        }

        override protected function getColumnIds(param1:CommonStatsVO) : Vector.<String>
        {
            return new <String>[ColumnConstants.PLAYER,ColumnConstants.TANK,ColumnConstants.DAMAGE,ColumnConstants.FRAG,ColumnConstants.XP,ColumnConstants.MEDAL];
        }
    }
}
