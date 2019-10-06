package net.wg.gui.lobby.settings.vo
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class ShowDamageIconVO extends DAAPIDataClass
    {

        public var checkBoxLabel:String = "";

        public var tooltip:String = "";

        public function ShowDamageIconVO(param1:Object)
        {
            super(param1);
        }
    }
}
