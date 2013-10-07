package com.xvm.types.stat
{
    public dynamic class VData
    {
        // received
        public var b:Number = NaN;       // battles (int)
        public var w:Number = NaN;       // wins (int)
        public var l:Number = NaN;       // level (int)
        public var d:Number = NaN;       // damageDealt (int)
        public var f:Number = NaN;       // frags (int)
        public var s:Number = NaN;       // spotted (int)

        // calculated
        public var r:Number = NaN;       // current vehicle win rate (int)
        public var db:Number = NaN;      // damageDealt per battle (int)
        public var fb:Number = NaN;      // frags per battle (float)
        public var sb:Number = NaN;      // spotted per battle (float)
        public var dv:Number = NaN;      // db/vehicleHP (float)
        public var te:Number = NaN;      // tank eff (int, 1-10)
        public var teff:Number = NaN;    // tank eff (int, 1-99999)
    }
}
