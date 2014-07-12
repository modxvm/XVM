package net.wg.gui.components.tooltips.VO
{
    public class ToolTipFinalStatsVO extends Object
    {
        
        public function ToolTipFinalStatsVO(param1:Object) {
            super();
            this.parseHash(param1);
        }
        
        public static var TYPE_STOTTED:String = "spotted";
        
        public static var TYPE_ASSIST:String = "assist";
        
        public static var TYPE_CRITS:String = "crits";
        
        public static var TYPE_DAMAGE:String = "damage";
        
        public static var TYPE_KILL:String = "kill";
        
        public static var TYPE_TEAM_KILL:String = "teamKill";
        
        public static var CRIT_TYPE_DAMAGE:String = "critDamage";
        
        public static var CRIT_TYPE_DISTRUCTION:String = "critDestruction";
        
        public static var CRIT_TYPE_WOUND:String = "critWound";
        
        private var valideTypes:Array = null;
        
        public var type:String = null;
        
        public var values:String = null;
        
        public var discript:String = null;
        
        public var value:Number = NaN;
        
        public var disabled:Boolean = true;
        
        public var critDamage:String = null;
        
        public var critDestruction:String = null;
        
        public var critWound:String = null;
        
        private function parseHash(param1:Object) : void {
            this.valideTypes = [TYPE_STOTTED,TYPE_ASSIST,TYPE_CRITS,TYPE_DAMAGE,TYPE_KILL,TYPE_TEAM_KILL];
            this.type = (param1.hasOwnProperty("type")) && !(param1["type"] == undefined) && this.valideTypes.indexOf(param1["type"],0) >= 0?param1["type"]:null;
            this.values = (param1.hasOwnProperty("values")) && !(param1["values"] == undefined)?param1["values"]:null;
            this.discript = (param1.hasOwnProperty("discript")) && !(param1["discript"] == undefined)?param1["discript"]:null;
            this.value = (param1.hasOwnProperty("value")) && !(param1["value"] == undefined)?param1["value"]:null;
            this.disabled = (param1.hasOwnProperty("disabled")) && !(param1["disabled"] == undefined)?param1["disabled"]:true;
            if(this.type == TYPE_CRITS)
            {
                this.critDamage = (param1.hasOwnProperty(CRIT_TYPE_DAMAGE)) && !(param1[CRIT_TYPE_DAMAGE] == "") && !(param1[CRIT_TYPE_DAMAGE] == undefined)?param1[CRIT_TYPE_DAMAGE]:null;
                this.critDestruction = (param1.hasOwnProperty(CRIT_TYPE_DISTRUCTION)) && !(param1[CRIT_TYPE_DISTRUCTION] == "") && !(param1[CRIT_TYPE_DISTRUCTION] == undefined)?param1[CRIT_TYPE_DISTRUCTION]:null;
                this.critWound = (param1.hasOwnProperty(CRIT_TYPE_WOUND)) && !(param1[CRIT_TYPE_WOUND] == "") && !(param1[CRIT_TYPE_WOUND] == undefined)?param1[CRIT_TYPE_WOUND]:null;
            }
        }
    }
}
