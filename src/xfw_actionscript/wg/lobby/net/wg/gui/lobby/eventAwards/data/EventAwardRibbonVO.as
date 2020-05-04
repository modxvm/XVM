package net.wg.gui.lobby.eventAwards.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.lobby.components.data.RibbonAwardsVO;

    public class EventAwardRibbonVO extends DAAPIDataClass
    {

        private static const VEHICLE_AWARDS_LBL:String = "vehicleAwards";

        private static const ABILITY_AWARDS_LBL:String = "abilityAwards";

        private static const OTHER_AWARDS_LBL:String = "otherAwards";

        private var _vehicleAwards:RibbonAwardsVO = null;

        private var _abilityAwards:RibbonAwardsVO = null;

        private var _otherAwards:RibbonAwardsVO = null;

        public function EventAwardRibbonVO(param1:Object = null)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == VEHICLE_AWARDS_LBL && param2 != null)
            {
                this._vehicleAwards = new RibbonAwardsVO(param2);
                return false;
            }
            if(param1 == ABILITY_AWARDS_LBL && param2 != null)
            {
                this._abilityAwards = new RibbonAwardsVO(param2);
                return false;
            }
            if(param1 == OTHER_AWARDS_LBL && param2 != null)
            {
                this._otherAwards = new RibbonAwardsVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            if(this._vehicleAwards)
            {
                this._vehicleAwards.dispose();
                this._vehicleAwards = null;
            }
            if(this._abilityAwards)
            {
                this._abilityAwards.dispose();
                this._abilityAwards = null;
            }
            if(this._otherAwards)
            {
                this._otherAwards.dispose();
                this._otherAwards = null;
            }
            super.onDispose();
        }

        public function get awards() : Vector.<RibbonAwardsVO>
        {
            var _loc1_:Vector.<RibbonAwardsVO> = new Vector.<RibbonAwardsVO>(0);
            if(this._vehicleAwards != null)
            {
                _loc1_.push(this._vehicleAwards);
            }
            if(this._abilityAwards != null)
            {
                _loc1_.push(this._abilityAwards);
            }
            if(this._otherAwards != null)
            {
                _loc1_.push(this._otherAwards);
            }
            return _loc1_;
        }
    }
}
