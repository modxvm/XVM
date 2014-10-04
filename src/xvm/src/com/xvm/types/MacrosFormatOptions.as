package com.xvm.types
{
    import com.xvm.types.dossier.VehicleDossierCut;
    public class MacrosFormatOptions
    {
        public var skip:Object = null;

        public var ready:Boolean = false;
        public var alive:Boolean = false;
        public var isCurrentPlayer:Boolean = false;
        public var isTeamKiller:Boolean = false;
        public var isCurrentSquad:Boolean = false;
        public var squadIndex:Number = NaN;

        public var curHealth:int = NaN;
        public var delta:int = NaN;
        public var damageType:String = null;
        public var damageFlag:int = NaN;
        public var entityName:String = null;
        public var blowedUp:Boolean = false;

        public var vdata:VehicleDossierCut = null;

        // internal use
        public var __subname:String = null;
    }
}
