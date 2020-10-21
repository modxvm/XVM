package net.wg.gui.lobby.eventMessageWindow.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class MessageContentVO extends DAAPIDataClass
    {

        public var money:String = "";

        public var label:String = "";

        public var message:String = "";

        public var labelExecute:String = "";

        public var costValue:int = -1;

        public var costString:String = "";

        public var storageAmount:int = -1;

        public var currency:String = "";

        public var isExecuteEnabled:Boolean = true;

        public var iconPath:String = "";

        public var messagePreset:String = "";

        public var closeByEscape:Boolean = true;

        public var showCloseButton:Boolean = true;

        public function MessageContentVO(param1:Object)
        {
            super(param1);
        }
    }
}
