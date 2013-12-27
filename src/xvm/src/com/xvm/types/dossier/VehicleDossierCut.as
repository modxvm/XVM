package com.xvm.types.dossier
{
   import net.wg.data.daapi.base.DAAPIDataClass;

   public class VehicleDossierCut extends DAAPIDataClass
   {
        public function VehicleDossierCut(data:Object)
        {
            super(data);
        }

        public var vehId:int;
        public var battles:int;
        public var wins:int;
        public var mastery:int;
        public var xp:int;
   }
}
