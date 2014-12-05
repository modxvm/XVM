package net.wg.gui.lobby.quests.data.seasonAwards
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class BaseSeasonAwardVO extends DAAPIDataClass
    {
        
        public function BaseSeasonAwardVO(param1:Object)
        {
            super(param1);
        }
        
        public var type:int = -1;
    }
}
