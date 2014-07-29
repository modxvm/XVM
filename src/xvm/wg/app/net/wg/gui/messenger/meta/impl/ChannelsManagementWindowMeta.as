package net.wg.gui.messenger.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class ChannelsManagementWindowMeta extends AbstractWindowView
    {
        
        public function ChannelsManagementWindowMeta()
        {
            super();
        }
        
        public var getSearchLimitLabel:Function = null;
        
        public var searchToken:Function = null;
        
        public var joinToChannel:Function = null;
        
        public var createChannel:Function = null;
        
        public function getSearchLimitLabelS() : String
        {
            App.utils.asserter.assertNotNull(this.getSearchLimitLabel,"getSearchLimitLabel" + Errors.CANT_NULL);
            return this.getSearchLimitLabel();
        }
        
        public function searchTokenS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.searchToken,"searchToken" + Errors.CANT_NULL);
            this.searchToken(param1);
        }
        
        public function joinToChannelS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.joinToChannel,"joinToChannel" + Errors.CANT_NULL);
            this.joinToChannel(param1);
        }
        
        public function createChannelS(param1:String, param2:Boolean, param3:String, param4:String) : void
        {
            App.utils.asserter.assertNotNull(this.createChannel,"createChannel" + Errors.CANT_NULL);
            this.createChannel(param1,param2,param3,param4);
        }
    }
}
