package net.wg.gui.bootcamp.battleResult.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class BattleItemRendrerVO extends DAAPIDataClass
    {

        public var id:String = "";

        public var label:String = "";

        public var description:String = "";

        public var icon:String = "";

        public var iconTooltip:String = "";

        public var value:String = "";

        public function BattleItemRendrerVO(param1:Object)
        {
            super(param1);
        }
    }
}
