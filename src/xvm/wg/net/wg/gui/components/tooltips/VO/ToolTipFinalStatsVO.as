package net.wg.gui.components.tooltips.VO 
{
    public class ToolTipFinalStatsVO extends Object
    {
        public function ToolTipFinalStatsVO(arg1:Object)
        {
            super();
            this.parseHash(arg1);
            return;
        }

        internal function parseHash(arg1:Object):void
        {
            this.valideTypes = [TYPE_STOTTED, TYPE_ASSIST, TYPE_CRITS, TYPE_DAMAGE, TYPE_KILL, TYPE_TEAM_KILL];
            this.type = arg1.hasOwnProperty("type") && !(arg1["type"] == undefined) && this.valideTypes.indexOf(arg1["type"], 0) >= 0 ? arg1["type"] : null;
            this.values = arg1.hasOwnProperty("values") && !(arg1["values"] == undefined) ? arg1["values"] : null;
            this.discript = arg1.hasOwnProperty("discript") && !(arg1["discript"] == undefined) ? arg1["discript"] : null;
            this.value = arg1.hasOwnProperty("value") && !(arg1["value"] == undefined) ? arg1["value"] : null;
            this.disabled = arg1.hasOwnProperty("disabled") && !(arg1["disabled"] == undefined) ? arg1["disabled"] : true;
            if (this.type == TYPE_CRITS) 
            {
                this.critDamage = arg1.hasOwnProperty(CRIT_TYPE_DAMAGE) && !(arg1[CRIT_TYPE_DAMAGE] == "") && !(arg1[CRIT_TYPE_DAMAGE] == undefined) ? arg1[CRIT_TYPE_DAMAGE] : null;
                this.critDestruction = arg1.hasOwnProperty(CRIT_TYPE_DISTRUCTION) && !(arg1[CRIT_TYPE_DISTRUCTION] == "") && !(arg1[CRIT_TYPE_DISTRUCTION] == undefined) ? arg1[CRIT_TYPE_DISTRUCTION] : null;
                this.critWound = arg1.hasOwnProperty(CRIT_TYPE_WOUND) && !(arg1[CRIT_TYPE_WOUND] == "") && !(arg1[CRIT_TYPE_WOUND] == undefined) ? arg1[CRIT_TYPE_WOUND] : null;
            }
            return;
        }

        
        {
            TYPE_STOTTED = "spotted";
            TYPE_ASSIST = "assist";
            TYPE_CRITS = "crits";
            TYPE_DAMAGE = "damage";
            TYPE_KILL = "kill";
            TYPE_TEAM_KILL = "teamKill";
            CRIT_TYPE_DAMAGE = "critDamage";
            CRIT_TYPE_DISTRUCTION = "critDestruction";
            CRIT_TYPE_WOUND = "critWound";
        }

        internal var valideTypes:Array=null;

        public var type:String=null;

        public var values:String=null;

        public var discript:String=null;

        public var value:Number=NaN;

        public var disabled:Boolean=true;

        public var critDamage:String=null;

        public var critDestruction:String=null;

        public var critWound:String=null;

        public static var TYPE_STOTTED:String="spotted";

        public static var TYPE_ASSIST:String="assist";

        public static var TYPE_CRITS:String="crits";

        public static var TYPE_DAMAGE:String="damage";

        public static var TYPE_KILL:String="kill";

        public static var TYPE_TEAM_KILL:String="teamKill";

        public static var CRIT_TYPE_DAMAGE:String="critDamage";

        public static var CRIT_TYPE_DISTRUCTION:String="critDestruction";

        public static var CRIT_TYPE_WOUND:String="critWound";
    }
}
