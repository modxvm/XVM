import com.xvm.DataTypes.*;

class com.xvm.DataTypes.VData
{
        // received
        public var id:Number = 0;        // vehicle id
        public var b:Number = NaN;       // battles (int)
        public var w:Number = NaN;       // wins (int)
        public var dmg:Number = NaN;     // damageDealt (int)
        public var frg:Number = NaN;     // frags (int)
        public var spo:Number = NaN;     // spotted (int)
        public var def:Number = NaN;     // defence (int)
        public var sur:Number = NaN;     // survived (int)

        // calculated
        public var winrate:Number = NaN; // current vehicle win rate (int)
        public var db:Number = NaN;      // damageDealt per battle (int)
        public var fb:Number = NaN;      // frags per battle (float)
        public var sb:Number = NaN;      // spotted per battle (float)
        public var dv:Number = NaN;      // db/vehicleHP (float)
        public var xte:Number = NaN;     // xTE tank eff (int, 1-100)

        public var data:VehicleData = null;
}
