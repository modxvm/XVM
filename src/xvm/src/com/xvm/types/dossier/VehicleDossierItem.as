package com.xvm.types.dossier
{
   import net.wg.data.daapi.base.DAAPIDataClass;

   public class VehicleDossierItem extends DAAPIDataClass
   {
        public function VehicleDossierItem(param1:Object)
        {
            super(param1);
        }

        public var vehId:int;
        public var battles:int;
        public var wins:int;
        public var mastery:int;
        public var xp:int;
   }
}
