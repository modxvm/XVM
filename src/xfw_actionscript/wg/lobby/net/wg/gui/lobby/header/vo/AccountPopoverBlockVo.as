package net.wg.gui.lobby.header.vo
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class AccountPopoverBlockVO extends DAAPIDataClass
    {

        public var formation:String = "";

        public var formationName:String = "";

        public var position:String = "";

        public var btnLabel:String = "";

        public var btnEnabled:Boolean = false;

        public var btnTooltip:String = "";

        public var disabledTooltip:String = "";

        public var isDoActionBtnVisible:Boolean = true;

        public var isTextFieldNameVisible:Boolean = true;

        public function AccountPopoverBlockVO(param1:Object)
        {
            super(param1);
        }
    }
}
