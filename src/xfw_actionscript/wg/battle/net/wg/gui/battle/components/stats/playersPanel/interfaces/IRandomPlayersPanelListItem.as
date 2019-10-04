package net.wg.gui.battle.components.stats.playersPanel.interfaces
{
    import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelDynamicSquad;

    public interface IRandomPlayersPanelListItem extends IPlayersPanelListItem
    {

        function getDynamicSquad() : PlayersPanelDynamicSquad;

        function setSquadNoSound(param1:Boolean) : void;

        function setSquadState(param1:int) : void;

        function setSquad(param1:Boolean, param2:int) : void;
    }
}
