package net.wg.gui.components.tooltips.VO 
{
    public class AchievementVO extends Object
    {
        public function AchievementVO(arg1:Object)
        {
            super();
            this.parsHash(arg1);
            return;
        }

        internal function parsHash(arg1:Object):void
        {
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=NaN;
            var loc6:*=0;
            var loc7:*=undefined;
            this.aName = arg1.hasOwnProperty("name") && !(arg1["name"] == undefined) ? arg1["name"] : null;
            this.discription = arg1.hasOwnProperty("descr") && !(arg1["descr"] == undefined) ? arg1["descr"] : null;
            this.inactive = arg1.hasOwnProperty("inactive") && !(arg1["inactive"] == undefined) ? arg1["inactive"] : false;
            this.heroInfo = arg1.hasOwnProperty("heroInfo") && !(arg1["heroInfo"] == "") && !(arg1["heroInfo"] == undefined) ? arg1["heroInfo"] : null;
            this.section = arg1.hasOwnProperty("section") && !(arg1["section"] == undefined) ? arg1["section"] : null;
            this.type = arg1.hasOwnProperty("type") && !(arg1["type"] == undefined) ? arg1["type"] : null;
            this.value = arg1.hasOwnProperty("value") && !(arg1["value"] == undefined) ? arg1["value"] : NaN;
            this.icon = arg1.hasOwnProperty("icon") && !(arg1["icon"] == undefined) ? arg1["icon"] : null;
            var loc1:*=arg1.hasOwnProperty("params") && !(arg1["params"] == undefined) ? true : false;
            if (loc1) 
            {
                if (arg1["params"] is Array && arg1["params"][0] is Array) 
                {
                    loc2 = arg1["params"][0];
                    this.params = [];
                    loc3 = loc2.length;
                    loc4 = "";
                    loc5 = NaN;
                    loc6 = 0;
                    while (loc6 < loc3) 
                    {
                        if (((loc4 = (loc7 = loc2[loc6])[0]) == "vehiclesToKill" || loc4 == "vehiclesToResearch") && loc7[1] is Array) 
                        {
                            this.vehicleToKill = loc7[1];
                            loc5 = loc7[2];
                            this.vehicleToKillLeft = loc5 - this.vehicleToKill.length;
                            if (this.vehicleToKillLeft < 0) 
                            {
                                this.vehicleToKillLeft = 0;
                            }
                        }
                        else 
                        {
                            loc5 = loc7[1];
                        }
                        this.params.push({"id":loc4, "val":loc5});
                        ++loc6;
                    }
                }
            }
            this.stats = arg1.hasOwnProperty("stats") && !(arg1["stats"] == undefined) ? arg1["stats"] : null;
            if (this.stats) 
            {
                this.classParams = arg1["stats"].hasOwnProperty("classParams") && !(arg1["stats"]["classParams"] == undefined) ? arg1["stats"]["classParams"] : null;
            }
            return;
        }

        public var aName:String=null;

        public var discription:String=null;

        public var inactive:Boolean=false;

        public var heroInfo:String=null;

        public var section:String=null;

        public var type:String=null;

        public var value:Number=NaN;

        public var icon:String=null;

        public var params:Array=null;

        public var stats:Object=null;

        public var vehicleToKill:Array=null;

        public var vehicleToKillLeft:Number=0;

        public var classParams:Array=null;
    }
}
