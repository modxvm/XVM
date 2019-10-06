package net.wg.gui.lobby.vehiclePreview.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class VehPreviewHeaderVO extends DAAPIDataClass
    {

        public var tankType:String = "";

        public var tankInfo:String = "";

        public var closeBtnLabel:String = "";

        public var backBtnLabel:String = "";

        public var backBtnDescrLabel:String = "";

        public var titleText:String = "";

        public var isPremiumIGR:Boolean = false;

        public var showCloseBtn:Boolean = true;

        public function VehPreviewHeaderVO(param1:Object)
        {
            super(param1);
        }
    }
}
