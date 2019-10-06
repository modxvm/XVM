package net.wg.gui.lobby.vehicleCustomization.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.data.constants.Values;

    public class CustomizationSlotIdVO extends DAAPIDataClass
    {

        public var areaId:int = -1;

        public var slotId:int = -1;

        public var regionId:int = -1;

        public function CustomizationSlotIdVO(param1:Object)
        {
            super(param1);
        }

        override public function isEquals(param1:DAAPIDataClass) : Boolean
        {
            var _loc2_:CustomizationSlotIdVO = param1 as CustomizationSlotIdVO;
            if(_loc2_ == null)
            {
                return false;
            }
            return this.regionId == _loc2_.regionId && this.slotId == _loc2_.slotId && this.areaId == _loc2_.areaId;
        }

        public function isEmpty() : Boolean
        {
            return this.regionId == Values.DEFAULT_INT && this.slotId == Values.DEFAULT_INT && this.areaId == Values.DEFAULT_INT;
        }
    }
}
