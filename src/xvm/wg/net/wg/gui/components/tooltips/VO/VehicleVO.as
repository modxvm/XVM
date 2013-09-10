package net.wg.gui.components.tooltips.VO 
{
    import net.wg.utils.*;
    
    public class VehicleVO extends net.wg.gui.components.tooltips.VO.VehicleBaseVO
    {
        public function VehicleVO(arg1:Object)
        {
            super();
            this.parsHash(arg1);
            return;
        }

        internal function parsHash(arg1:Object):void
        {
            var loc2:*=null;
            var loc3:*=null;
            vName = arg1.hasOwnProperty("name") && !(arg1["name"] == undefined) ? arg1["name"] : "";
            vLevel = arg1.hasOwnProperty("level") && !(arg1["level"] == undefined) ? arg1["level"] : 1;
            vType = arg1.hasOwnProperty("type") && !(arg1["type"] == undefined) ? arg1["type"] : "";
            this.isPremium = arg1.hasOwnProperty("isPremium") && !(arg1["isPremium"] == undefined) ? arg1["isPremium"] : false;
            this.isFavorite = arg1.hasOwnProperty("isFavorite") && !(arg1["isFavorite"] == undefined) ? arg1["isFavorite"] : false;
            this.isElite = arg1.hasOwnProperty("isElite") && !(arg1["isElite"] == undefined) ? arg1["isElite"] : false;
            if (arg1.hasOwnProperty("locks") && !(arg1["locks"] == undefined)) 
            {
                loc2 = App.utils.locale;
                var loc4:*=0;
                var loc5:*=arg1["locks"];
                for (loc3 in loc5) 
                {
                    this.clanLockTime = arg1["locks"][loc3];
                    if (isNaN(this.clanLockTime)) 
                        continue;
                    this.clanLock = true;
                    this.clanLockType = loc3;
                    this.clanLockTimeStr = loc2.shortDate(this.clanLockTime) + " " + loc2.shortTime(this.clanLockTime);
                }
            }
            this.stats = arg1.hasOwnProperty("stats") && !(arg1["stats"] == undefined) ? arg1["stats"] : null;
            var loc1:*=arg1.hasOwnProperty("params") && !(arg1["params"] == undefined) ? arg1["params"] : null;
            if (loc1) 
            {
                if (loc1[0]) 
                    this.characteristics = loc1[0];
                if (loc1[1]) 
                    this.equipments = loc1[1];
            }
            if (arg1.hasOwnProperty("status") && !(arg1["status"] == undefined)) 
            {
                this.status = true;
                this.statusHeader = arg1["status"].hasOwnProperty("header") && !(arg1["status"]["header"] == undefined) ? arg1["status"]["header"] : "";
                this.statusLevel = arg1["status"].hasOwnProperty("level") && !(arg1["status"]["level"] == undefined) ? arg1["status"]["level"] : "";
                this.statusText = arg1["status"].hasOwnProperty("text") && !(arg1["status"]["text"] == undefined) ? arg1["status"]["text"] : "";
            }
            else 
            {
                this.statusHeader = null;
                this.statusLevel = null;
                this.statusText = null;
            }
            if (this.statusHeader || this.statusText) 
                this.status = true;
            return;
        }

        
        {
            LIGTH_TANK = "lightTank";
            MEDIUM_TANK = "mediumTank";
            HEAVY_TANK = "heavyTank";
            SPG_TANK = "SPG";
            AT_SPG_TANK = "AT-SPG";
        }

        public var isPremium:Boolean=false;

        public var isFavorite:Boolean=false;

        public var isElite:Boolean=false;

        public var clanLock:Boolean=false;

        public var clanLockTime:Number=NaN;

        public var clanLockTimeStr:String="";

        public var clanLockType:String="";

        public var status:Boolean=false;

        public var statusHeader:String=null;

        public var statusLevel:String=null;

        public var statusText:String=null;

        public var stats:Array=null;

        public var characteristics:Array=null;

        public var equipments:Array=null;

        public static var LIGTH_TANK:String="lightTank";

        public static var MEDIUM_TANK:String="mediumTank";

        public static var HEAVY_TANK:String="heavyTank";

        public static var SPG_TANK:String="SPG";

        public static var AT_SPG_TANK:String="AT-SPG";
    }
}
