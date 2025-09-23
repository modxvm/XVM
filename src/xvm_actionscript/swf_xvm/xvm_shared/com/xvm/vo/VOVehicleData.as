/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.vo
{
    import com.xvm.types.*;
    import com.xvm.types.dossier.*;

    public class VOVehicleData extends VOBase
    {
        public var vehCD:int;
        public var key:String;

        public var level:int;
        private var _vclass:String;
        public var nation:String;
        public var premium:Boolean;
        public var special:Boolean;
        public var isReserved:Boolean;
        public var role:String;

        public var hpStock:int;
        public var hpTop:int;
        public var visRadius:int;
        public var firingRadius:int;
        public var artyRadius:int;

        public var tierLo:int;
        public var tierHi:int;

        public var localizedName:String; // can be overrided by user
        public var localizedShortName:String;
        public var localizedFullName:String;

        public var turret:int;
        public var topTurretCD:int;

        public var wn8expDamage:Number;
        public var wn8expSpot:Number;
        public var wn8expWinRate:Number;
        public var wn8expDef:Number;
        public var wn8expFrag:Number;

        public var avgdmg:Number;
        public var topdmg:Number;
        public var avgfrg:Number;
        public var topfrg:Number;

        // additional

        public var shortName:String;

        // TODO: refactor
        public var __vehicleDossierCut:VehicleDossierCut;


        // PROPERTIES

        public function get vclass():String
        {
            return _vclass;
        }

        public function set vclass(value:String):void
        {
            _vclass = value;
            _vtype = VClassToVType(value);
        }

        private var _vtype:String;
        public function get vtype():String
        {
            return _vtype;
        }

        public function get sysname():String
        {
            return key.replace(':', '-');
        }

        public function VOVehicleData(data:Object = null)
        {
            super(data);
        }

        // PRIVATE

        // vclass = "mediumTank"
        // vtype = "MT"
        private static function VClassToVType(vclass:String):String
        {
            switch (vclass)
            {
                case VehicleClass.lightTank: return VehicleType.LT;
                case VehicleClass.mediumTank: return VehicleType.MT;
                case VehicleClass.heavyTank: return VehicleType.HT;
                case VehicleClass.AT_SPG: return VehicleType.TD;
                case VehicleClass.SPG: return VehicleType.SPG;
                default: return "";
            }
        }
   }
}
