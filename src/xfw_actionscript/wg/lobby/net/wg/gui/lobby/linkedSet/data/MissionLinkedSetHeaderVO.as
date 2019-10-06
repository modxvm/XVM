package net.wg.gui.lobby.linkedSet.data
{
    import net.wg.gui.lobby.missions.data.MissionPackHeaderBaseVO;
    import net.wg.gui.lobby.missions.data.CollapsedHeaderTitleBlockVO;

    public class MissionLinkedSetHeaderVO extends MissionPackHeaderBaseVO
    {

        public var info:String = "";

        public function MissionLinkedSetHeaderVO(param1:Object)
        {
            super(param1);
        }

        override public function get titleBlockClass() : Class
        {
            return CollapsedHeaderTitleBlockVO;
        }
    }
}
