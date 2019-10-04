package net.wg.gui.prebattle.squads.simple.vo
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class SimpleSquadBonusVO extends DAAPIDataClass
    {

        public var bonusValue:String = "";

        public var label:String = "";

        public var icon:String = "";

        public var tooltip:String = "";

        public var tooltipType:String = "";

        public function SimpleSquadBonusVO(param1:Object)
        {
            super(param1);
        }
    }
}
