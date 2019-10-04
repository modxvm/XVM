package net.wg.gui.prebattle.squads.simple.vo
{
    import net.wg.gui.rally.vo.RallyVO;
    import net.wg.gui.rally.interfaces.IRallySlotVO;

    public class SimpleSquadRallyVO extends RallyVO
    {

        public function SimpleSquadRallyVO(param1:Object)
        {
            super(param1);
        }

        override protected function initSlotsVO(param1:Object) : void
        {
            var _loc3_:Object = null;
            var _loc4_:SimpleSquadRallySlotVO = null;
            slots = new Vector.<IRallySlotVO>();
            var _loc2_:Array = param1 as Array;
            for each(_loc3_ in _loc2_)
            {
                _loc4_ = new SimpleSquadRallySlotVO(_loc3_);
                slots.push(_loc4_);
            }
        }
    }
}
