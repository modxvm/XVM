package net.wg.gui.messenger.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class ChannelComponentMeta extends net.wg.infrastructure.base.BaseDAAPIComponent
    {
        public function ChannelComponentMeta()
        {
            super();
            return;
        }

        public function isJoinedS():Boolean
        {
            App.utils.asserter.assertNotNull(this.isJoined, "isJoined" + net.wg.data.constants.Errors.CANT_NULL);
            return this.isJoined();
        }

        public function sendMessageS(arg1:String):Boolean
        {
            App.utils.asserter.assertNotNull(this.sendMessage, "sendMessage" + net.wg.data.constants.Errors.CANT_NULL);
            return this.sendMessage(arg1);
        }

        public function getHistoryS():String
        {
            App.utils.asserter.assertNotNull(this.getHistory, "getHistory" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getHistory();
        }

        public function getMessageMaxLengthS():int
        {
            App.utils.asserter.assertNotNull(this.getMessageMaxLength, "getMessageMaxLength" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getMessageMaxLength();
        }

        public var isJoined:Function=null;

        public var sendMessage:Function=null;

        public var getHistory:Function=null;

        public var getMessageMaxLength:Function=null;
    }
}
