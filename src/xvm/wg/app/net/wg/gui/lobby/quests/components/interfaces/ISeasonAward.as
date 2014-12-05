package net.wg.gui.lobby.quests.components.interfaces
{
    import net.wg.gui.lobby.quests.data.seasonAwards.BaseSeasonAwardVO;
    
    public interface ISeasonAward
    {
        
        function setData(param1:BaseSeasonAwardVO) : void;
        
        function getTabIndexItems() : Array;
    }
}
