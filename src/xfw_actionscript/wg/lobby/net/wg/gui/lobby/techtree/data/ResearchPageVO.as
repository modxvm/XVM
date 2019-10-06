package net.wg.gui.lobby.techtree.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class ResearchPageVO extends DAAPIDataClass
    {

        public var backBtnLabel:String = "";

        public var backBtnDescrLabel:String = "";

        public var isPremiumLayout:Boolean = false;

        public var benefit1IconSrc:String = "";

        public var benefit1LabelStr:String = "";

        public var benefit2IconSrc:String = "";

        public var benefit2LabelStr:String = "";

        public var benefit3IconSrc:String = "";

        public var benefit3LabelStr:String = "";

        public function ResearchPageVO(param1:Object)
        {
            super(param1);
        }
    }
}
