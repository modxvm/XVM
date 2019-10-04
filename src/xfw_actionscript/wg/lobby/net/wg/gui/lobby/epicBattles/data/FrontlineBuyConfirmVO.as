package net.wg.gui.lobby.epicBattles.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class FrontlineBuyConfirmVO extends DAAPIDataClass
    {

        public var title:String = "";

        public var content:String = "";

        public var titleBig:String = "";

        public var contentBig:String = "";

        public var buyBtnLabel:String = "";

        public var backBtnLabel:String = "";

        public function FrontlineBuyConfirmVO(param1:Object)
        {
            super(param1);
        }
    }
}
