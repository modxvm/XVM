package net.wg.gui.prebattle.squads.event.vo
{
    import net.wg.gui.rally.vo.RallyVO;
    import net.wg.gui.rally.interfaces.IRallySlotVO;

    public class EventSquadRallyVO extends RallyVO
    {

        public function EventSquadRallyVO(param1:Object)
        {
            super(param1);
        }

        override protected function initSlotsVO(param1:Object) : void
        {
            var _loc3_:Object = null;
            var _loc4_:EventSlotVO = null;
            slots = new Vector.<IRallySlotVO>();
            var _loc2_:Array = param1 as Array;
            for each(_loc3_ in _loc2_)
            {
                _loc4_ = new EventSlotVO(_loc3_);
                slots.push(_loc4_);
            }
        }
    }
}
