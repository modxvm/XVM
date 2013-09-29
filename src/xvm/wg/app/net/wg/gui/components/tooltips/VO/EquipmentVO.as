package net.wg.gui.components.tooltips.VO 
{
    import net.wg.data.constants.*;
    
    public class EquipmentVO extends Object
    {
        public function EquipmentVO(arg1:Object)
        {
            super();
            this.parsHash(arg1);
            return;
        }

        internal function parsHash(arg1:Object):void
        {
            this.eName = arg1.hasOwnProperty("name") && !(arg1["name"] == undefined) ? arg1["name"] : "";
            this.type = arg1.hasOwnProperty("type") && !(arg1["type"] == undefined) ? arg1["type"] : "";
            this.icon = arg1.hasOwnProperty("icon") && !(arg1["icon"] == undefined) ? arg1["icon"] : "";
            this.extraModuleInfo = arg1.hasOwnProperty(net.wg.data.constants.ValObject.EXTRA_MODULE_INFO) ? new net.wg.gui.components.tooltips.VO.ExtraModuleInfoVO(arg1[net.wg.data.constants.ValObject.EXTRA_MODULE_INFO]) : null;
            this.tooHeavy = arg1.hasOwnProperty("tooHeavy") && !(arg1["tooHeavy"] == undefined) ? arg1["tooHeavy"] : "";
            this.level = arg1.hasOwnProperty("level") && !(arg1["level"] == undefined) ? arg1["level"] : NaN;
            this.complex = arg1.hasOwnProperty("note") && !(arg1["note"] == undefined) ? true : false;
            if (this.complex) 
            {
                this.complexHeader = arg1["note"].hasOwnProperty("title") && !(arg1["note"]["title"] == undefined) ? arg1["note"]["title"] : "";
                this.complexNote = arg1["note"].hasOwnProperty("text") && !(arg1["note"]["text"] == undefined) ? arg1["note"]["text"] : "";
            }
            this.descr = arg1.hasOwnProperty("descr") && !(arg1["descr"] == undefined) ? arg1["descr"] : "";
            this.gold = arg1.hasOwnProperty("gold") && !(arg1["gold"] == undefined) ? arg1["gold"] : "";
            this.removeable = arg1.hasOwnProperty("removeable") && !(arg1["removeable"] == undefined) ? arg1["removeable"] : "";
            this.haveResearchXP = arg1.hasOwnProperty("haveResearchXP") && !(arg1["haveResearchXP"] == undefined) ? arg1["haveResearchXP"] : "";
            this.stats = arg1.hasOwnProperty("stats") && !(arg1["stats"] == undefined) ? arg1["stats"] : null;
            if (arg1.hasOwnProperty("params") && !(arg1["params"] == undefined)) 
            {
                this.params = arg1["params"][0] && !(arg1["params"][0] == undefined) && arg1["params"][0].length > 0 ? arg1["params"][0] : null;
                this.paramsAdd = arg1["params"][1] && !(arg1["params"][1] == undefined) && arg1["params"][1].length > 0 ? arg1["params"][1] : null;
            }
            else 
            {
                this.params = null;
                this.paramsAdd = null;
            }
            if (arg1.hasOwnProperty("paramsEx")) 
            {
                this.paramsEx = new net.wg.gui.components.tooltips.VO.EquipmentParamVO(arg1["paramsEx"]);
            }
            this.status = arg1.hasOwnProperty("status") && !(arg1["status"] == undefined) ? arg1["status"] : false;
            if (this.status) 
            {
                this.statusHeader = arg1["status"].hasOwnProperty("header") && !(arg1["status"]["header"] == undefined) ? arg1["status"]["header"] : "";
                this.statusText = arg1["status"].hasOwnProperty("text") && !(arg1["status"]["text"] == undefined) ? arg1["status"]["text"] : "";
                this.statusLevel = arg1["status"].hasOwnProperty("level") && !(arg1["status"]["level"] == undefined) ? arg1["status"]["level"] : "";
            }
            if (arg1.hasOwnProperty("effect") && !(arg1["effect"] == undefined)) 
            {
                this.effectOnUse = arg1["effect"].hasOwnProperty("onUse") && !(arg1["effect"]["onUse"] == undefined) ? arg1["effect"]["onUse"] : "";
                this.effectAlways = arg1["effect"].hasOwnProperty("always") && !(arg1["effect"]["always"] == undefined) ? arg1["effect"]["always"] : "";
                this.effectRestriction = arg1["effect"].hasOwnProperty("restriction") && !(arg1["effect"]["restriction"] == undefined) ? arg1["effect"]["restriction"] : "";
            }
            return;
        }

        public var eName:String="";

        public var type:String="";

        public var icon:String="";

        public var extraModuleInfo:net.wg.gui.components.tooltips.VO.ExtraModuleInfoVO=null;

        public var tooHeavy:Boolean=false;

        public var level:Number=NaN;

        public var complex:Boolean=false;

        public var complexHeader:String="";

        public var complexNote:String="";

        public var descr:String="";

        public var gold:Boolean=false;

        public var removeable:Boolean=false;

        public var haveResearchXP:Boolean=false;

        public var stats:Array=null;

        public var params:Array=null;

        public var paramsEx:Object=null;

        public var paramsAdd:Array=null;

        public var status:Boolean=false;

        public var statusHeader:String="";

        public var statusText:String="";

        public var statusLevel:String="";

        public var effectOnUse:String="";

        public var effectAlways:String="";

        public var effectRestriction:String="";
    }
}
