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
        
        public var closeAll:Function = null;
        
        public var channelCloseClick:Function = null;
        
        public function channelOpenClickS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.channelOpenClick,"channelOpenClick" + Errors.CANT_NULL);
            this.channelOpenClick(param1);
        }
        
        public function closeAllS() : void
        {
            App.utils.asserter.assertNotNull(this.closeAll,"closeAll" + Errors.CANT_NULL);
            this.closeAll();
        }
        
        public function channelCloseClickS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.channelCloseClick,"channelCloseClick" + Errors.CANT_NULL);
            this.channelCloseClick(param1);
        }
    }
}
