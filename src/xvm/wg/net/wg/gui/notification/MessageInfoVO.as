package net.wg.gui.notification 
{
    import net.wg.data.daapi.base.*;
    
    public class MessageInfoVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function MessageInfoVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        protected override function onDataWrite(arg1:String, arg2:Object):Boolean
        {
            if (arg1 == "showMore") 
            {
                this._showMoreVO = new net.wg.gui.notification.MoreInfoVO(arg2);
                this.showMore = arg2;
                return false;
            }
            return this.hasOwnProperty(arg1);
        }

        public function get showMoreVO():net.wg.gui.notification.MoreInfoVO
        {
            return this._showMoreVO;
        }

        public var type:String="";

        public var message:String="";

        public var icon:String="";

        public var defaultIcon:String="";

        public var showMore:Object;

        internal var _showMoreVO:net.wg.gui.notification.MoreInfoVO;

        public var filters:Array;
    }
}
