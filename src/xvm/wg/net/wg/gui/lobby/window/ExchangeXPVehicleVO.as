package net.wg.gui.lobby.window 
{
    import net.wg.data.daapi.base.*;
    
    public class ExchangeXPVehicleVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function ExchangeXPVehicleVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public var id:String="";

        public var vehicleType:String="";

        public var vehicleName:String="";

        public var xp:Number;

        public var isSelectCandidate:Boolean;

        public var vehicleIco:String="";

        public var nationIco:String="";
    }
}
