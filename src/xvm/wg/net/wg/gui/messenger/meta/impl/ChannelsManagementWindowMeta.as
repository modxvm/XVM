package net.wg.gui.messenger.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class ChannelsManagementWindowMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function ChannelsManagementWindowMeta()
        {
            super();
            return;
        }

        public function getSearchLimitLabelS():String
        {
            App.utils.asserter.assertNotNull(this.getSearchLimitLabel, "getSearchLimitLabel" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getSearchLimitLabel();
        }

        public function searchTokenS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.searchToken, "searchToken" + net.wg.data.constants.Errors.CANT_NULL);
            this.searchToken(arg1);
            return;
        }

        public function joinToChannelS(arg1:Number):void
        {
            App.utils.asserter.assertNotNull(this.joinToChannel, "joinToChannel" + net.wg.data.constants.Errors.CANT_NULL);
            this.joinToChannel(arg1);
            return;
        }

        public function createChannelS(arg1:String, arg2:Boolean, arg3:String, arg4:String):void
        {
            App.utils.asserter.assertNotNull(this.createChannel, "createChannel" + net.wg.data.constants.Errors.CANT_NULL);
            this.createChannel(arg1, arg2, arg3, arg4);
            return;
        }

        public var getSearchLimitLabel:Function=null;

        public var searchToken:Function=null;

        public var joinToChannel:Function=null;

        public var createChannel:Function=null;
    }
}
