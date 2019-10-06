package net.wg.gui.bootcamp.battleResult.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class PlayerVehicleVO extends DAAPIDataClass
    {

        public var name:String = "";

        public var typeIcon:String = "";

        public function PlayerVehicleVO(param1:Object)
        {
            super(param1);
        }
    }
}
