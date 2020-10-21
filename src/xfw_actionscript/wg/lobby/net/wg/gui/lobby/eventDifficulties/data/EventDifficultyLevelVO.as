package net.wg.gui.lobby.eventDifficulties.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class EventDifficultyLevelVO extends DAAPIDataClass
    {

        public var numPhases:String = "";

        public var title:String = "";

        public var description:String = "";

        public var level:int = 0;

        public var selected:Boolean = false;

        public var enabled:Boolean = false;

        public function EventDifficultyLevelVO(param1:Object)
        {
            super(param1);
        }
    }
}
