package net.wg.gui.lobby.eventHangar.data
{
    import net.wg.gui.components.paginator.vo.ToolTipVO;

    public class EventProgressBannerVO extends ToolTipVO
    {

        public var fuel:int = 0;

        public var isAssault:Boolean = false;

        public var showNew:Boolean = false;

        public function EventProgressBannerVO(param1:Object)
        {
            super(param1);
        }
    }
}
