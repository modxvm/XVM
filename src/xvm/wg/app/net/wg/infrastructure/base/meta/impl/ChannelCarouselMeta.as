package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.data.constants.Errors;
    
    public class ChannelCarouselMeta extends BaseDAAPIComponent
    {
        
        public function ChannelCarouselMeta()
        {
            super();
        }
        
        public var channelOpenClick:Function = null;
        
        public var minimizeAllChannels:Function = null;
        
        public var closeAll:Function = null;
        
        public var closeAllExceptCurrent:Function = null;
        
        public var channelCloseClick:Function = null;
        
        public function channelOpenClickS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.channelOpenClick,"channelOpenClick" + Errors.CANT_NULL);
            this.channelOpenClick(param1);
        }
        
        public function minimizeAllChannelsS() : void
        {
            App.utils.asserter.assertNotNull(this.minimizeAllChannels,"minimizeAllChannels" + Errors.CANT_NULL);
            this.minimizeAllChannels();
        }
        
        public function closeAllS() : void
        {
            App.utils.asserter.assertNotNull(this.closeAll,"closeAll" + Errors.CANT_NULL);
            this.closeAll();
        }
        
        public function closeAllExceptCurrentS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.closeAllExceptCurrent,"closeAllExceptCurrent" + Errors.CANT_NULL);
            this.closeAllExceptCurrent(param1);
        }
        
        public function channelCloseClickS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.channelCloseClick,"channelCloseClick" + Errors.CANT_NULL);
            this.channelCloseClick(param1);
        }
    }
}
