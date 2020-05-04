package net.wg.gui.prebattle.squads.event.vo
{
    import net.wg.gui.prebattle.squads.simple.vo.SimpleSquadRallySlotVO;

    public class EventSlotVO extends SimpleSquadRallySlotVO
    {

        private static const GENERAL:String = "general";

        private var _general:GeneralVO = null;

        public function EventSlotVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == GENERAL)
            {
                this._general = new GeneralVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            if(this._general != null)
            {
                this._general.dispose();
                this._general = null;
            }
            super.onDispose();
        }

        public function get general() : GeneralVO
        {
            return this._general;
        }

        public function set general(param1:GeneralVO) : void
        {
            this._general = param1;
        }
    }
}
