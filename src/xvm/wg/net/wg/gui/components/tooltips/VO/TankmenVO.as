package net.wg.gui.components.tooltips.VO 
{
    import net.wg.gui.components.tooltips.helpers.*;
    
    public class TankmenVO extends Object
    {
        public function TankmenVO(arg1:Object)
        {
            super();
            this.parsHash(arg1);
            return;
        }

        internal function parsHash(arg1:Object):void
        {
            var loc11:*=0;
            this.vName = arg1.hasOwnProperty("name") && !(arg1["name"] == undefined) ? arg1["name"] : "";
            this.rank = arg1.hasOwnProperty("rank") && !(arg1["rank"] == undefined) ? arg1["rank"] : "";
            this.vehicleContour = arg1.hasOwnProperty("vehicleContour") && !(arg1["vehicleContour"] == undefined) ? arg1["vehicleContour"] : "";
            this.currentVehicleType = arg1.hasOwnProperty("currentVehicleType") && !(arg1["currentVehicleType"] == undefined) ? arg1["currentVehicleType"] : "";
            this.newSkillsCount = arg1.hasOwnProperty("newSkillsCount") && !(arg1["newSkillsCount"] == undefined) ? arg1["newSkillsCount"] : 0;
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*="";
            loc1 = arg1.hasOwnProperty("roleLevelPenalty") && !(arg1["roleLevelPenalty"] == undefined) ? arg1["roleLevelPenalty"] : 0;
            loc2 = arg1.hasOwnProperty("roleLevelBonus") && !(arg1["roleLevelBonus"] == undefined) ? arg1["roleLevelBonus"] : 0;
            loc3 = arg1.hasOwnProperty("roleLevelBrothers") && !(arg1["roleLevelBrothers"] == undefined) ? arg1["roleLevelBrothers"] : 0;
            loc4 = arg1.hasOwnProperty("roleLevel") && !(arg1["roleLevel"] == undefined) ? arg1["roleLevel"] : 0;
            var loc6:*=loc1 != 0 ? this.getSign(loc1) + loc1.toString() : "";
            var loc7:*=loc2 != 0 ? this.getSign(loc2) + loc2.toString() : "";
            var loc8:*=loc3 != 0 ? this.getSign(loc3) + loc3.toString() : "";
            if (!(loc1 == 0) || !(loc2 == 0) || !(loc3 == 0)) 
                loc5 = " (" + loc4 + loc6 + loc7 + loc8 + ")";
            else 
                loc5 = "";
            loc4 = loc4 + (loc1 + loc2 + loc3);
            this.vehicleName = arg1.hasOwnProperty("vehicleName") && !(arg1["vehicleName"] == undefined) ? arg1["vehicleName"] : "";
            this.currentVehicleName = arg1.hasOwnProperty("currentVehicleName") && !(arg1["currentVehicleName"] == undefined) ? arg1["currentVehicleName"] : "";
            this.isCurrentVehiclePremium = arg1.hasOwnProperty("isCurrentVehiclePremium") && !(arg1["isCurrentVehiclePremium"] == undefined) ? arg1["isCurrentVehiclePremium"] : false;
            var loc9:*=this.vehicleName == this.currentVehicleName || this.currentVehicleName == "" || this.isCurrentVehiclePremium ? net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER : net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_ALERT;
            this.params = [];
            this.params[0] = [];
            this.params[0][0] = arg1.role;
            this.params[0][1] = net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc4.toString() + "%" + loc5, loc9, 12, "$TextFont");
            var loc10:*;
            if ((loc10 = arg1.hasOwnProperty("skills") ? arg1["skills"] : []).length > 0 && !(loc10[0].id == "new_skill")) 
            {
                loc11 = 0;
                while (loc11 < loc10.length) 
                {
                    this.params[loc11 + 1] = [];
                    this.params[loc11 + 1][0] = loc10[loc11].hasOwnProperty("label") && !(loc10[loc11]["label"] == undefined) ? loc10[loc11]["label"] : "";
                    this.params[loc11 + 1][1] = loc10[loc11].hasOwnProperty("level") && !(loc10[loc11]["level"] == undefined) ? loc10[loc11]["level"] + "%" : "";
                    this.params[loc11 + 1][2] = loc10[loc11].hasOwnProperty("enabled") && !(loc10[loc11]["enabled"] == undefined) ? loc10[loc11]["enabled"] : "";
                    ++loc11;
                }
            }
            if (arg1.hasOwnProperty("status") && !(arg1["status"] == undefined)) 
            {
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

        internal function getSign(arg1:Number):String
        {
            return arg1 >= 0 ? "+" : "";
        }

        public var vName:String="";

        public var rank:String="";

        public var vehicleContour:String="";

        public var currentVehicleType:String="";

        public var params:Array=null;

        public var vehicleName:String="";

        public var currentVehicleName:String="";

        public var isCurrentVehiclePremium:Boolean=false;

        public var newSkillsCount:Number=0;

        public var status:Boolean=false;

        public var statusHeader:String=null;

        public var statusLevel:String=null;

        public var statusText:String=null;
    }
}
