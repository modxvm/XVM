package net.wg.gui.notification 
{
    import net.wg.data.daapi.base.*;
    
    public class NotificationInfoVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function NotificationInfoVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        protected override function onDataWrite(arg1:String, arg2:Object):Boolean
        {
            if (arg1 == "message") 
            {
                this._messageVO = new net.wg.gui.notification.MessageInfoVO(arg2);
                return false;
            }
            return this.hasOwnProperty(arg1);
        }

        public function get messageVO():net.wg.gui.notification.MessageInfoVO
        {
            return this._messageVO;
        }

        public var message:Object;

        internal var _messageVO:net.wg.gui.notification.MessageInfoVO;

        public var priority:Boolean;

        public var auxData:Array;

        public var notify:Boolean;
    }
}
