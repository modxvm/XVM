package com.xvm.types
{
    import com.xvm.types.dossier.VehicleDossierCut;
    public class MacrosFormatOptions
    {
        public var skip:Object = null;
        public var curHealth:int = NaN;
        public var delta:int = NaN;
        public var damageType:String = null;
        public var damageFlag:int = NaN;
        public var entityName:String = null;
        public var dead:Boolean = false;
        public var blowedUp:Boolean = false;
        public var darken:Boolean = false;
        public var vdata:VehicleDossierCut = null;

        // internal use
        public var __subname:String = null;
    }
}
