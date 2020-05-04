package net.wg.gui.prebattle.squads.event.vo
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class GeneralVO extends DAAPIDataClass
    {

        public var name:String = "";

        public var romanLevel:String = "";

        public var logo:uint;

        public function GeneralVO(param1:Object)
        {
            super(param1);
        }
    }
}
