package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class ChannelCarouselMeta extends net.wg.infrastructure.base.BaseDAAPIComponent
    {
        public function ChannelCarouselMeta()
        {
            super();
            return;
        }

        public function channelOpenClickS(arg1:Number):void
        {
            App.utils.asserter.assertNotNull(this.channelOpenClick, "channelOpenClick" + net.wg.data.constants.Errors.CANT_NULL);
            this.channelOpenClick(arg1);
            return;
        }

        public function channelCloseClickS(arg1:Number):void
        {
            App.utils.asserter.assertNotNull(this.channelCloseClick, "channelCloseClick" + net.wg.data.constants.Errors.CANT_NULL);
            this.channelCloseClick(arg1);
            return;
        }

        public var channelOpenClick:Function=null;

        public var channelCloseClick:Function=null;
    }
}
