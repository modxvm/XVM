/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.wg
{
    import flash.events.*;
    import net.wg.infrastructure.interfaces.IImageData;

    public class ImageXVM extends ImageWG
    {
        public function ImageXVM()
        {
            super();
        }

        override protected function setImgData(data:IImageData) : void
        {
            super.setImgData(data);
            if (this._imgData.ready)
            {
                imageDataReady();
            }
        }

        override protected function onImgDataCompleteHandler(e:Event) : void
        {
            super.onImgDataCompleteHandler(e);
            imageDataReady();
        }

        override protected function onImgDataIoErrorHandler(e:IOErrorEvent) : void
        {
            super.onImgDataIoErrorHandler(e);
            if (_loadFailed)
            {
                dispatchEvent(e);
            }
        }

        protected function imageDataReady() : void
        {
            dispatchEvent(new Event(Event.COMPLETE));
        }
    }
}
