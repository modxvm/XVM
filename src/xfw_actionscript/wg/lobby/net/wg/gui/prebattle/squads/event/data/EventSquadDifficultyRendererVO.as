package net.wg.gui.prebattle.squads.event.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class EventSquadDifficultyRendererVO extends DAAPIDataClass
    {

        public var label:String = "";

        public var difficultyLevel:int = -1;

        public var tooltip:String = "";

        public var disabled:Boolean = false;

        public var showInfoIcon:Boolean = false;

        public var showLockIcon:Boolean = false;

        public function EventSquadDifficultyRendererVO(param1:Object)
        {
            super(param1);
        }
    }
}
