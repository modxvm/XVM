package net.wg.gui.components.common.ticker
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class RSSEntryVO extends DAAPIDataClass
    {

        public var id:String = "";

        public var title:String = "";

        public var summary:String = "";

        public function RSSEntryVO(param1:Object)
        {
            super(param1);
        }
    }
}
