package com.xvm.types.dossier
{
    import com.xvm.*;
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class VehicleDossier extends DossierBase
    {
        public function VehicleDossier(data:Object)
        {
            super(data);
        }

        public var vehId:int;
    }
}
