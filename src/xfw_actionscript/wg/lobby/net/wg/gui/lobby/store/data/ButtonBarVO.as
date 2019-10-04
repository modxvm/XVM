package net.wg.gui.lobby.store.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class ButtonBarVO extends DAAPIDataClass
    {

        public var label:String = "";

        public var id:String = "";

        public var linkage:String = "";

        public function ButtonBarVO(param1:Object)
        {
            super(param1);
        }
    }
}
