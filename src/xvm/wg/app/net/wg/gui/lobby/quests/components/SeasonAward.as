package net.wg.gui.lobby.quests.components
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.lobby.quests.components.interfaces.ISeasonAward;
    import net.wg.gui.lobby.quests.data.seasonAwards.BaseSeasonAwardVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class SeasonAward extends UIComponent implements ISeasonAward
    {
        
        public function SeasonAward()
        {
            super();
        }
        
        public function setData(param1:BaseSeasonAwardVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
        
        public function getTabIndexItems() : Array
        {
            return null;
        }
    }
}
