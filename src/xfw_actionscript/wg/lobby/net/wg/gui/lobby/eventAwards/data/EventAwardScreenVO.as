package net.wg.gui.lobby.eventAwards.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class EventAwardScreenVO extends DAAPIDataClass
    {

        public var closeBtnLabel:String = "";

        public var background:String = "";

        public var buttonLinkage:String = "";

        public var buttonLabel:String = "";

        public var headerLinkage:String = "";

        public var headerData:Object = null;

        public var prizeLinkage:String = "";

        public var prizeData:Object = null;

        public function EventAwardScreenVO(param1:Object = null)
        {
            super(param1);
        }

        override protected function onDispose() : void
        {
            this.headerData = null;
            this.prizeData = null;
            super.onDispose();
        }
    }
}
